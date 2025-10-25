# ByBug Policy

ByBug Policy; web, mobil ve masaüstü projeleri için politika dokümanlarını hızla üretmenizi sağlayan bir servistir. Flutter arayüzü ile bilgileri toplayıp otomatik olarak depoya aktarır; aynı işlemi terminalden yönetebilmeniz için Bash ve Python tabanlı CLI araçları da proje ile birlikte gelir.

## Özellikler
- Flutter arayüzü üzerinden proje detaylarını girip politikanızı yayınlayın.
- Terminalden Bash scripti ile hızlıca kayıt oluşturun.
- Python CLI ile çoklu platformlarda aynı iş akışını tekrarlayın.
- Tüm istemciler `.env` dosyası üzerinden paylaşılan API yapılandırmasını kullanır.

## Kurulum
1. [Flutter](https://docs.flutter.dev/get-started/install) 3.35+ ve Python 3.10+ kurulu olduğundan emin olun. Bash CLI için `curl` gereklidir.
2. Depoyu klonlayın:
   ```bash
   git clone https://github.com/JeaFrid/bybug_policy_global.git
   cd bybug_policy_global
   ```
3. Proje kök dizininde aşağıdaki formatta bir `.env` dosyası oluşturun (değerleri kendi gizli bilgilerinizle doldurun):
   ```env
   BYBUG_DB_URL=https://database.example.com:6620
   BYBUG_DB_TOKEN=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   ```
4. Flutter bağımlılıklarını yükleyin:
   ```bash
   flutter pub get
   ```
   > Eğer SDK erişiminiz yoksa bu adımı kendi ortamınızda çalıştırın.
5. Python istemci bağımlılıklarını yükleyin:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r python/requirements.txt
   ```

## Flutter Uygulamasını Çalıştırma
```bash
flutter run
```
Web sürümünü derlemek isterseniz `flutter run -d chrome` veya `flutter build web` komutlarını kullanabilirsiniz. Uygulama `.env` dosyasındaki bilgileri kullanarak depoya bağlanır.

## Bash CLI (Linux)
```bash
cli/linux/bybug_policy.sh
```
Script, gerekli bilgileri sizden alır, API'ye gönderir ve `https://policy.bybug.com.tr/<site-adi>` formatındaki bağlantınızı üretir.

## Python CLI
```bash
python python/bybug_policy_cli.py
```
Python sürümü aynı iş akışını uygular; `.env` dosyasından yapılandırmayı çeker ve kayıt işlemini gerçekleştirir.

## Depodan Güncelleme Alma
```bash
git pull
```
Güncel kodu aldıktan sonra yeni bağımlılıklar varsa `flutter pub get` ve `pip install -r python/requirements.txt` komutlarını yeniden çalıştırın.

## Katkıda Bulunma
Pull request göndermeden önce yerel testlerinizi ve CLI komutlarını doğruladığınızdan emin olun. `.env` dosyası hassas bilgiler içerdiğinden asla depoya eklemeyin.
