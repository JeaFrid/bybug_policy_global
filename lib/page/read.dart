import 'package:bybugpolicy/page/home.dart';
import 'package:bybugpolicy/services/bybugdatabase.dart';
import 'package:bybugpolicy/theme/color.dart';
import 'package:bybugpolicy/tools/get_data.dart';
import 'package:bybugpolicy/widget/gradient_mask.dart';
import 'package:bybugpolicy/widget/snack.dart';
import 'package:bybugpolicy/widget/text.dart';
import 'package:bybugpolicy/widget/visibility.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:just_manager/just_manager.dart';

class PolicyReader extends StatefulWidget {
  final String name;
  const PolicyReader({super.key, required this.name});

  @override
  State<PolicyReader> createState() => _PolicyReaderState();
}

class _PolicyReaderState extends State<PolicyReader> {
  JM<bool> isLoading = JM(true);
  JM<String> markdownText = JM("");
  final ScrollController _markdownScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      if (widget.name.trim().isNotEmpty) {
        var datas = await ByBugDatabase.getAll("policy_bucket");
        if (datas.isNotEmpty) {
          for (var element in datas) {
            var value = element["value"];
            final website = value["website"];
            final company = value["company"];
            final city = value["city"];
            final email = value["email"];
            final type = value["type"];
            if (widget.name == website) {
              var dataPolicy = getDataList(
                website,
                company,
                email,
                city,
                type + 1,
              );
              List<List> mdList = [];
              for (var e in dataPolicy) {
                if (e[1] == "Markdown") {
                  mdList.add(e);
                }
              }
              for (var text in mdList) {
                markdownText.callSet(markdownText() + text[2]);
              }
              markdownText.up();
              isLoading.set(false);
              break;
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _markdownScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return JMScaffold(
      backgroundColor: bg,
      listenables: [isLoading],
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [
                          Colors.purpleAccent.withOpacity(1),
                          Colors.indigoAccent.withOpacity(1),
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: EdgeInsets.all(2),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: navColor,
                      ),
                      child: Scrollbar(
                        controller: _markdownScrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: _markdownScrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              btn(
                                "Politika Bağlantısı",
                                "assets/link.png",
                                dontScale: true,
                                onTap: () async {
                                  await copy(
                                    "https://policy.bybug.com.tr/${widget.name}",
                                  );
                                  if(!context.mounted)return;
                                  getInfoSnack(context, "Kopyalandı!");
                                },
                              ),
                              GptMarkdown(
                                markdownText(),
                                style: GoogleFonts.roboto(color: textColor),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AnimatedVisibility(visible: isLoading(), child: _loading()),
          ],
        );
      },
    );
  }

  Scaffold _loading() {
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientMask(
              colors: [Colors.purpleAccent, Colors.indigoAccent],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  h2("ByBug Policy", textAlign: TextAlign.center),
                  p("Politikalar Yarat!"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GradientMask(
              colors: [Colors.purpleAccent, Colors.indigoAccent],
              child: CupertinoActivityIndicator(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
