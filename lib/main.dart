// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_clean_mvvm/app/dependency_injection.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();
  runApp(MyApp());
}
