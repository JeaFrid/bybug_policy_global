import 'package:bybugpolicy/services/bybugdatabase.dart';
import 'package:bybugpolicy/theme/color.dart';
import 'package:bybugpolicy/widget/gradient_mask.dart';
import 'package:bybugpolicy/widget/pressable.dart';
import 'package:bybugpolicy/widget/snack.dart';
import 'package:bybugpolicy/widget/text.dart';
import 'package:bybugpolicy/widget/textfield.dart';
import 'package:bybugpolicy/widget/visibility.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:just_manager/just_manager.dart';

JM<int> projectType = JM(4);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final website = TextEditingController();
  final company = TextEditingController();
  final city = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return JMScaffold(
      backgroundColor: bg,
      listenables: [projectType],
      body: () {
        final isCompact = MediaQuery.sizeOf(context).width < 720;
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(isCompact ? 16 : 20),
                  child: isCompact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GradientMask(
                              colors: [
                                Colors.purpleAccent,
                                Colors.indigoAccent,
                              ],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  h2(
                                    "ByBug Policy",
                                    textAlign: TextAlign.center,
                                  ),
                                  p("Politikalar Yarat!"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                btn(
                                  "Github",
                                  "assets/github.png",
                                  onTap: () {
                                    openUrl(
                                      "https://github.com/JeaFrid/bybug_policy_global",
                                    );
                                  },
                                ),
                                btn(
                                  "YouTube",
                                  "assets/youtube.png",
                                  onTap: () {
                                    openUrl(
                                      "https://www.youtube.com/@K%C4%B1rm%C4%B1z%C4%B1Patika",
                                    );
                                  },
                                ),
                                btn(
                                  "Instagram",
                                  "assets/social-media.png",
                                  onTap: () {
                                    openUrl(
                                      "https://www.instagram.com/jeafridayofficial/",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GradientMask(
                              colors: [
                                Colors.purpleAccent,
                                Colors.indigoAccent,
                              ],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  h2(
                                    "ByBug Policy",
                                    textAlign: TextAlign.center,
                                  ),
                                  p("Politikalar Yarat!"),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                btn(
                                  "Github",
                                  "assets/github.png",
                                  onTap: () {
                                    openUrl(
                                      "https://github.com/JeaFrid/bybug_policy_global",
                                    );
                                  },
                                ),
                                btn(
                                  "YouTube",
                                  "assets/youtube.png",
                                  onTap: () {
                                    openUrl(
                                      "https://www.youtube.com/@K%C4%B1rm%C4%B1z%C4%B1Patika",
                                    );
                                  },
                                ),
                                btn(
                                  "Instagram",
                                  "assets/social-media.png",
                                  onTap: () {
                                    openUrl(
                                      "https://www.instagram.com/jeafridayofficial/",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purpleAccent.withOpacity(0.2),
                                    Colors.indigoAccent.withOpacity(0.2),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: EdgeInsets.all(4),
                              child: SizedBox(
                                width: 300,
                                child: textfield(
                                  textController: website,
                                  icon: Icons.web_stories_outlined,
                                  nonMargin: true,
                                  text: "Web Site Adresi",
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purpleAccent.withOpacity(0.2),
                                    Colors.indigoAccent.withOpacity(0.2),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: EdgeInsets.all(4),
                              child: SizedBox(
                                width: 300,
                                child: textfield(
                                  textController: company,
                                  icon: Icons.home_work_outlined,
                                  nonMargin: true,
                                  text: "Şirket / Uygulama Adı",
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purpleAccent.withOpacity(0.2),
                                    Colors.indigoAccent.withOpacity(0.2),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: EdgeInsets.all(4),
                              child: SizedBox(
                                width: 300,
                                child: textfield(
                                  textController: city,
                                  icon: Icons.location_on_outlined,
                                  nonMargin: true,
                                  text: "Şehir / Ülke",
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purpleAccent.withOpacity(0.2),
                                    Colors.indigoAccent.withOpacity(0.2),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: EdgeInsets.all(4),
                              child: SizedBox(
                                width: 300,
                                child: textfield(
                                  nonMargin: true,
                                  textController: email,
                                  icon: Icons.email_outlined,
                                  text: "E-Posta Adresi",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SelectProject(),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: GradientMask(
                            colors: [Colors.purpleAccent, Colors.indigoAccent],
                            child: h2(
                              "ByBug Policy Nedir?",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width(context) < 800
                              ? width(context) * 0.9
                              : width(context) * 0.5,
                          child: p(
                            "Projeniz için bilgilerinizi alarak otomatik olarak politika sitenizi oluşturan bir web sitedir.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(isCompact ? 16 : 20),
                child: isCompact
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          btn(
                            "Yayınla",
                            "assets/stream.png",
                            onTap: () async {
                              String tag =
                                  CosmosRandom.string(5) +
                                  CosmosRandom.randomTag();
                              await ByBugDatabase.add("policy_bucket", tag, {
                                "website": website.text,
                                "company": company.text,
                                "city": city.text,
                                "email": email.text,
                                "type": projectType(),
                              });
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          p(
                            "Politikalarınızı ücretsiz yayınlayabilirsiniz.",
                            color: Colors.white,
                          ),
                          btn(
                            "Yayınla",
                            "assets/stream.png",
                            onTap: () async {
                              loading(context);
                              String tag =
                                  CosmosRandom.string(5) +
                                  CosmosRandom.randomTag();
                              await ByBugDatabase.add("policy_bucket", tag, {
                                "website": website.text,
                                "company": company.text,
                                "city": city.text,
                                "email": email.text,
                                "type": projectType(),
                              });
                              website.clear();
                              company.clear();
                              city.clear();
                              email.clear();
                              projectType.set(4);

                              await openUrl(
                                "https://policy.bybug.com.tr/${website.text}",
                              );
                              if (!context.mounted) return;
                              loadingPop(context);
                            },
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget btn(String title, String image, {bool? dontScale, Function()? onTap}) {
  JM<bool> isEnter = JM(false);
  return MouseRegion(
    onEnter: (event) {
      isEnter.set(true);
    },
    onExit: (event) {
      isEnter.set(false);
    },
    child: JMListener(
      listenables: [isEnter],
      childBuilder: () {
        return Pressable(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: AnimatedScale(
            duration: Duration(milliseconds: 40),
            scale: dontScale == true
                ? 1
                : isEnter()
                ? 1.05
                : 1,
            child: Pressable(
              onTap: () {
                if (onTap != null) {
                  onTap();
                }
              },
              child: Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: navColor,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.indigoAccent.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                ),
                child: GradientMask(
                  colors: [Colors.purpleAccent, Colors.indigoAccent],
                  child: Row(
                    children: [
                      Image.asset(
                        image,
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      bold(title),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

class SelectProject extends StatefulWidget {
  const SelectProject({super.key});

  @override
  State<SelectProject> createState() => _SelectProjectState();
}

class _SelectProjectState extends State<SelectProject> {
  JM<bool> isOpen = JM(false);
  @override
  Widget build(BuildContext context) {
    return JMListener(
      listenables: [isOpen, projectType],
      childBuilder: () {
        return Column(
          children: [
            Pressable(
              onTap: () {
                isOpen.set(!isOpen());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    colors: [
                      Colors.purpleAccent.withOpacity(0.2),
                      Colors.indigoAccent.withOpacity(0.2),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(2),
                margin: EdgeInsets.all(4),
                child: SizedBox(
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      color: navColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          p(
                            projectType() == 0
                                ? "Blog Sayfası"
                                : projectType() == 1
                                ? "E-Ticaret Sitesi"
                                : projectType() == 2
                                ? "Mobil Uygulama"
                                : "Proje Türünü Seçiniz",
                          ),
                          Icon(
                            isOpen()
                                ? Icons.keyboard_double_arrow_down
                                : Icons.keyboard_double_arrow_right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedVisibility(
              visible: isOpen(),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: subP("Projenizi en iyi hangisi anlatıyor?"),
                  ),
                  Pressable(
                    onTap: () {
                      projectType.set(0);
                      isOpen.set(false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.purpleAccent.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.all(2),
                      margin: EdgeInsets.all(4),
                      child: SizedBox(
                        width: 300,
                        child: Container(
                          decoration: BoxDecoration(
                            color: navColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                subP("Blog Sayfası"),
                                Icon(Icons.web, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Pressable(
                    onTap: () {
                      projectType.set(1);
                      isOpen.set(false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                          colors: [
                            Colors.purpleAccent.withOpacity(0.2),
                            Colors.indigoAccent.withOpacity(0.2),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(2),
                      margin: EdgeInsets.all(4),
                      child: SizedBox(
                        width: 300,
                        child: Container(
                          decoration: BoxDecoration(
                            color: navColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                subP("E-Ticaret Sitesi"),
                                Icon(Icons.shopping_basket_outlined, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Pressable(
                    onTap: () {
                      projectType.set(2);
                      isOpen.set(false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.indigoAccent.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.all(2),
                      margin: EdgeInsets.all(4),
                      child: SizedBox(
                        width: 300,
                        child: Container(
                          decoration: BoxDecoration(
                            color: navColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                subP("Mobil Uygulama"),
                                Icon(Icons.phone_android, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
