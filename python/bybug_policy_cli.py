#!/usr/bin/env python3
"""
Command-line interface for publishing ByBug Policy entries using the shared API.
"""

from __future__ import annotations

import os
import random
import string
import sys
from pathlib import Path

import requests
from dotenv import load_dotenv

PROJECT_ROOT = Path(__file__).resolve().parents[1]
ENV_PATH = PROJECT_ROOT / ".env"
API_BUCKET = "policy_bucket"


def ensure_env_loaded() -> None:
    """Load environment variables from .env and validate required keys."""
    if not ENV_PATH.exists():
        sys.stderr.write("❌ Ortam dosyası (.env) bulunamadı.\n")
        sys.exit(1)

    load_dotenv(ENV_PATH)
    if not os.getenv("BYBUG_DB_URL") or not os.getenv("BYBUG_DB_TOKEN"):
        sys.stderr.write(
            "❌ BYBUG_DB_URL ve BYBUG_DB_TOKEN değerleri .env dosyasında tanımlı olmalıdır.\n"
        )
        sys.exit(1)


def prompt_non_empty(message: str) -> str:
    """Prompt until a non-empty response is provided."""
    while True:
        try:
            value = input(message).strip()
        except (EOFError, KeyboardInterrupt):
            sys.stderr.write("\nİşlem kullanıcı tarafından iptal edildi.\n")
            sys.exit(1)
        if value:
            return value
        print("Bu alan boş bırakılamaz. Lütfen tekrar deneyin.")


def choose_project_type() -> int:
    print("\nProje türünü seçiniz:")
    print("  1) Blog Sayfası")
    print("  2) E-Ticaret Sitesi")
    print("  3) Mobil Uygulama")
    mapping = {"1": 0, "2": 1, "3": 2}
    while True:
        selection = prompt_non_empty("Seçiminiz (1-3): ")
        if selection in mapping:
            return mapping[selection]
        print("Lütfen 1, 2 veya 3 değerlerinden birini giriniz.")


def build_payload(data: dict) -> dict:
    return {
        "bucket": API_BUCKET,
        "tag": data["tag"],
        "value": {
            "website": data["website"],
            "company": data["company"],
            "city": data["city"],
            "email": data["email"],
            "type": data["project_type"],
        },
    }


def publish_policy(url: str, token: str, payload: dict) -> requests.Response:
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}",
    }
    return requests.post(f"{url}/add", json=payload, headers=headers, timeout=15)


def main() -> None:
    print("==============================================")
    print("ByBug Policy CLI Modeline Hoş Geldin!")
    print("JeaFriday tarafından geliştirildi. Lütfen kullanımda referans verin!")
    print("==============================================\n")

    ensure_env_loaded()
    base_url = os.environ["BYBUG_DB_URL"]
    auth_token = os.environ["BYBUG_DB_TOKEN"]

    website_input = prompt_non_empty("Site adını giriniz (ör: myapp.com): ")
    website = website_input.strip()
    print(f"Kullanılacak site adı: {website}")

    company = prompt_non_empty("Şirket / Uygulama adını giriniz: ")
    city = prompt_non_empty("Şehir / Ülke bilgisini giriniz: ")
    email = prompt_non_empty("İletişim e-posta adresini giriniz: ")
    project_type = choose_project_type()

    tag = "".join(random.choices(string.ascii_lowercase + string.digits, k=10))

    payload = build_payload(
        {
            "tag": tag,
            "website": website,
            "company": company,
            "city": city,
            "email": email,
            "project_type": project_type,
        }
    )

    try:
        response = publish_policy(base_url, auth_token, payload)
    except requests.RequestException as exc:
        sys.stderr.write(f"❌ İstek gönderilirken bir hata oluştu: {exc}\n")
        sys.exit(1)

    if response.status_code not in {200, 201}:
        sys.stderr.write(
            f"❌ İstek başarısız oldu. HTTP kodu: {response.status_code}\n"
        )
        sys.stderr.write(f"Sunucu yanıtı:\n{response.text}\n")
        sys.exit(1)

    print("✔️ Bilgiler başarıyla depoya gönderildi.")
    print("\nPolitika sayfanız hazır:")
    print(f"👉 https://policy.bybug.com.tr/{website}")


if __name__ == "__main__":
    main()
