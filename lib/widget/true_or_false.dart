import 'package:bybugpolicy/theme/color.dart';
import 'package:bybugpolicy/tools/navigator.dart';
import 'package:bybugpolicy/widget/pressable.dart';
import 'package:bybugpolicy/widget/sizer.dart';
import 'package:bybugpolicy/widget/text.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

void showTrueOrFalseDialog(
  BuildContext context,
  String title,
  String about,
  String successText,
  String discussText,
  Function() onSuccess,
  Function() onDiscuss, {
  bool? notSuccess,
  List<Widget>? children,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ListenableBuilder(
        listenable: Listenable.merge([]),
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: navColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: widthSizer(context) * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h3(title, color: defaultColor),
                      p(about),
                      Column(children: children ?? []),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Pressable(
                              onTap: () async {
                                pop(context);
                                onDiscuss();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: defaultColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: bold(discussText),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          notSuccess == true
                              ? SizedBox()
                              : Expanded(
                                  child: Pressable(
                                    onTap: () async {
                                      pop(context);
                                      onSuccess();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: defaultColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: bold(successText),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
