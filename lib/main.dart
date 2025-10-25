import 'package:bybugpolicy/page/home.dart';
import 'package:bybugpolicy/page/read.dart';
import 'package:bybugpolicy/services/bybugdatabase.dart';
import 'package:bybugpolicy/theme/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr', null);
  await dotenv.load(fileName: ".env");
  final dbUrl = dotenv.env["BYBUG_DB_URL"];
  final dbToken = dotenv.env["BYBUG_DB_TOKEN"];
  if (dbUrl == null ||
      dbToken == null ||
      dbUrl.trim().isEmpty ||
      dbToken.trim().isEmpty) {
    throw Exception(
      "ByBug Policy configuration is missing. Please provide BYBUG_DB_URL and BYBUG_DB_TOKEN in .env.",
    );
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ByBugDB.initialize(
    url: dbUrl,
    authToken: dbToken,
  );
  runApp(const MyApp());
}

String? _policyNameFromUrl() {
  if (!kIsWeb) {
    return null;
  }

  final uri = Uri.base;
  final pathSegments = uri.pathSegments.where((segment) => segment.isNotEmpty).toList();
  if (pathSegments.isNotEmpty) {
    final lastSegment = pathSegments.last;
    if (lastSegment != 'index.html') {
      return Uri.decodeComponent(lastSegment);
    }
  }

  if (uri.hasFragment) {
    final fragmentSegments = uri.fragment
        .split('/')
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .toList();
    if (fragmentSegments.isNotEmpty) {
      return Uri.decodeComponent(fragmentSegments.last);
    }
  }

  return null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final policyName = _policyNameFromUrl();
    return MaterialApp(
      title: 'ByBug Policy',
      debugShowCheckedModeBanner: false,
      scrollBehavior: TransparentScrollBehavior(),
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: defaultColor,
          selectionColor: defaultColor.withOpacity(0.4),
          selectionHandleColor: defaultColor,
        ),
      ),
      home: (policyName != null && policyName.trim().isNotEmpty)
          ? PolicyReader(name: policyName.trim())
          : const HomePage(),
    );
  }
}

class TransparentScrollBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      thumbVisibility: false,
      thickness: 0,
      interactive: false,
      child: child,
    );
  }
}
