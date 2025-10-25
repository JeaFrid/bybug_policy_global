import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:bybugpolicy/theme/color.dart';

class SizerResponsive extends StatelessWidget {
  final Widget child;
  const SizerResponsive({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 505
        ? child
        : Scaffold(
            backgroundColor: bg,
            body: SafeArea(child: mobile(context)),
          );
  }

  Widget mobile(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset(
              "assets/camii.jpg",
              width: width(context),
              height: height(context),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(30),
              width: 450,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(1),
                    offset: Offset(1, 1),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double widthSizer(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 505
      ? MediaQuery.sizeOf(context).width
      : 450;
}
