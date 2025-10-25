import 'package:bybugpolicy/tools/const.dart';


List getDataList(
  String internet,
  String companyName,
  String email,
  String city,
  int option,
) {
  if (option == 1) {
    return [
      [
        "Gizlilik Sözleşmesi",
        "Markdown",
        blogGizlilikPolitikasiMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Gizlilik Sözleşmesi",
        "HTML",
        blogGizlilikPolitikasiHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Gizlilik Sözleşmesi",
        "Düz Metin",
        blogGizlilikPolitikasiDuzMetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "Markdown",
        blogKullanimKosullariMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "HTML",
        blogKullanimKosullariHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "Düz Metin",
        blogKullanimKosullariDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "Markdown",
        blogKullanimKosullariMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "HTML",
        blogKullanimKosullariHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "Düz Metin",
        blogKullanimKosullariDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
    ];
  } else if (option == 2) {
    return [
      [
        "Gizlilik Sözleşmesi",
        "Markdown",
        eticaretGizlilikPolitikasiMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Gizlilik Sözleşmesi",
        "HTML",
        eticaretGizlilikPolitikasiHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Gizlilik Sözleşmesi",
        "Düz Metin",
        eticaretGizlilikPolitikasiDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "Markdown",
        eticaretKullanimKosullariMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "HTML",
        eticaretKullanimKosullariHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "Düz Metin",
        eticaretKullanimKosullariDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "Markdown",
        eticaretCerezKullanimiMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "HTML",
        eticaretCerezKullanimiHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "Düz Metin",
        eticaretCerezKullanimiDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
    ];
  } else if (option == 3) {
    return [
      [
        "Gizlilik Sözleşmesi",
        "Markdown",
        mobilUygulamaGizlilikPolitikasiMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Gizlilik Sözleşmesi",
        "HTML",
        mobilUygulamaGizlilikPolitikasiHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Gizlilik Sözleşmesi",
        "Düz Metin",
        mobilUygulamaGizlilikPolitikasiDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "Markdown",
        mobilUygulamaKullanimKosullariMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "HTML",
        mobilUygulamaKullanimKosullariHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Kullanım Koşulları",
        "Düz Metin",
        mobilUygulamaKullanimKosullariDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "Markdown",
        mobilUygulamaCerezKullanimiMarkdown
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "HTML",
        mobilUygulamaCerezKullanimiHTML
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
      [
        "Çerez Politikası",
        "Düz Metin",
        mobilUygulamaCerezKullanimiDuzmetin
            .replaceAll("webadresi", internet)
            .replaceAll("şirketadı", companyName)
            .replaceAll("email@email", email)
            .replaceAll("sehir", city),
      ],
    ];
  } else {
    return [];
  }
}
