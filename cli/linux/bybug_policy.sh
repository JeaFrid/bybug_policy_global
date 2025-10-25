#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
ENV_FILE="${PROJECT_ROOT}/.env"
API_BUCKET="policy_bucket"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "❌ Ortam dosyası (.env) bulunamadı. Lütfen proje kök dizininde oluşturun." >&2
  exit 1
fi

set -a
source "${ENV_FILE}"
set +a

if [[ -z "${BYBUG_DB_URL:-}" || -z "${BYBUG_DB_TOKEN:-}" ]]; then
  echo "❌ BYBUG_DB_URL ve BYBUG_DB_TOKEN değerleri .env dosyasında tanımlı olmalıdır." >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "❌ curl yüklü değil. Lütfen kurup tekrar deneyin." >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "❌ python3 bulunamadı. Sisteminizde Python 3 kurulmalıdır." >&2
  exit 1
fi

echo "=============================================="
echo "ByBug Policy CLI Modeline Hoş Geldin!"
echo "JeaFriday tarafından geliştirildi. Lütfen kullanımda referans verin!"
echo "=============================================="
echo

read -rp "Site adını giriniz (ör: myapp.com): " website_input
while [[ -z "${website_input// }" ]]; do
  read -rp "Site adı boş olamaz, tekrar giriniz: " website_input
done

website="$(printf '%s' "${website_input}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
echo "Kullanılacak site adı: ${website}"

read -rp "Şirket / Uygulama adını giriniz: " company
while [[ -z "${company// }" ]]; do
  read -rp "Bu alan boş olamaz, tekrar giriniz: " company
done

read -rp "Şehir / Ülke bilgisini giriniz: " city
while [[ -z "${city// }" ]]; do
  read -rp "Bu alan boş olamaz, tekrar giriniz: " city
done

read -rp "İletişim e-posta adresini giriniz: " email
while [[ -z "${email// }" ]]; do
  read -rp "Bu alan boş olamaz, tekrar giriniz: " email
done

echo
echo "Proje türünü seçiniz:"
echo "  1) Blog Sayfası"
echo "  2) E-Ticaret Sitesi"
echo "  3) Mobil Uygulama"

project_type=""
while [[ -z "${project_type}" ]]; do
  read -rp "Seçiminiz (1-3): " selection
  case "${selection}" in
    1) project_type=0 ;;
    2) project_type=1 ;;
    3) project_type=2 ;;
    *) echo "Lütfen 1, 2 veya 3 değerlerinden birini giriniz." ;;
  esac
done

random_tag() {
  local chars='abcdefghijklmnopqrstuvwxyz0123456789'
  local tag=""
  for _ in {1..10}; do
    local idx=$((RANDOM % ${#chars}))
    tag+="${chars:idx:1}"
  done
  echo "${tag}"
}

TAG="$(random_tag)"

export BYBUG_POLICY_WEBSITE="${website}"
export BYBUG_POLICY_COMPANY="${company}"
export BYBUG_POLICY_CITY="${city}"
export BYBUG_POLICY_EMAIL="${email}"
export BYBUG_POLICY_TYPE="${project_type}"
export BYBUG_POLICY_TAG="${TAG}"
export BYBUG_POLICY_BUCKET="${API_BUCKET}"

payload="$(python3 <<'PYTHONSCRIPT'
import json
import os

payload = {
    "bucket": os.environ["BYBUG_POLICY_BUCKET"],
    "tag": os.environ["BYBUG_POLICY_TAG"],
    "value": {
        "website": os.environ["BYBUG_POLICY_WEBSITE"],
        "company": os.environ["BYBUG_POLICY_COMPANY"],
        "city": os.environ["BYBUG_POLICY_CITY"],
        "email": os.environ["BYBUG_POLICY_EMAIL"],
        "type": int(os.environ["BYBUG_POLICY_TYPE"]),
    },
}
print(json.dumps(payload))
PYTHONSCRIPT
)"

response_file="$(mktemp)"
http_code="$(curl -sS -o "${response_file}" \
  -w "%{http_code}" \
  -X POST "${BYBUG_DB_URL}/add" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${BYBUG_DB_TOKEN}" \
  -d "${payload}")"

if [[ "${http_code}" != "200" && "${http_code}" != "201" ]]; then
  echo "❌ İstek başarısız oldu. HTTP kodu: ${http_code}" >&2
  echo "Sunucu yanıtı:" >&2
  cat "${response_file}" >&2
  rm -f "${response_file}"
  exit 1
fi

echo "✔️ Bilgiler başarıyla depoya gönderildi."
rm -f "${response_file}"

echo
echo "Politika sayfanız hazır:"
echo "👉 https://policy.bybug.com.tr/${website}"
