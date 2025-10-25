import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bybugpolicy/theme/color.dart';

Widget h1(String text, {Color? color}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: color ?? textColor,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      );
    },
  );
}

Widget h2(String text, {TextAlign? textAlign, List<Shadow>? shadows}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.openSans(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 25,
          shadows: shadows,
        ),
      );
    },
  );
}

Widget h3(
  String text, {
  int? maxLines,
  double? height,
  TextOverflow? overflow,
  double? size,
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: GoogleFonts.openSans(
          height: height ?? 0.98,
          color: color ?? textColor,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontSize: size ?? 20,
        ),
      );
    },
  );
}

Widget h4(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    },
  );
}

Widget h5(
  String text, {
  int? maxLines,
  TextOverflow? overflow,
  double? size,
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: GoogleFonts.openSans(
          height: 0.98,
          color: color ?? textColor,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontSize: size ?? 16,
        ),
      );
    },
  );
}

Widget p(
  String text, {
  int? maxLines,
  Color? color,
  TextOverflow? overflow,
  TextAlign? textAlign,
  double? size,
  TextDecoration? decoration,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: GoogleFonts.openSans(
          color: color ?? textColor,
          fontSize: size ?? 14,
          decoration: decoration,
        ),
      );
    },
  );
}

Widget subP(
  String text, {
  int? maxLines,
  Color? color,
  TextOverflow? overflow,
  double? size,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: GoogleFonts.openSans(
          color: color ?? textColor,
          fontSize: size ?? 12,
          fontWeight: fontWeight,
        ),
      );
    },
  );
}

Widget subPName(
  String text, {
  int? maxLines,
  Color? color,
  TextOverflow? overflow,
  double? size,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text.length > 8 ? text.substring(0, 8) : text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: GoogleFonts.openSans(
          color: color ?? textColor,
          fontSize: size ?? 12,
          fontWeight: fontWeight,
        ),
      );
    },
  );
}

Widget bold(
  String text, {
  int? maxLines,
  TextOverflow? overflow,
  TextAlign? textAlign,
  double? size,
  Color? color,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: GoogleFonts.openSans(
          color: color ?? textColor,
          fontWeight: FontWeight.bold,
          fontSize: size ?? 14,
        ),
      );
    },
  );
}

Widget italic(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontStyle: FontStyle.italic,
          fontSize: 14,
        ),
      );
    },
  );
}

Widget h1Dark(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      );
    },
  );
}

Widget h2Dark(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      );
    },
  );
}

Widget h3Dark(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    },
  );
}

Widget h4Dark(
  String text, {
  int? maxLines,
  TextOverflow? overflow,
  Color? color,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.openSans(
          color: color ?? textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    },
  );
}

Widget h5Dark(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
    },
  );
}

Widget pDark(
  String text, {
  int? maxLines,
  TextOverflow? overflow,
  double? size,
}) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.openSans(color: textColor, fontSize: size ?? 14),
      );
    },
  );
}

Widget subPDark(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(color: textColor, fontSize: 12),
      );
    },
  );
}

Widget boldDark(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
    },
  );
}

Widget italicDark(String text) {
  return ListenableBuilder(
    listenable: Listenable.merge([]),
    builder: (BuildContext context, Widget? child) {
      return Text(
        text,
        style: GoogleFonts.openSans(
          color: textColor,
          fontStyle: FontStyle.italic,
          fontSize: 14,
        ),
      );
    },
  );
}
