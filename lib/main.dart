// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// Project imports:
import '/app/dependency_injection.dart';
import '/presentation/resources/language_manager.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: const [englishLocale, nepaliLocale],
    path: assetsPathLocalisation,
    child: Phoenix(child: MyApp()),
  ));
}
