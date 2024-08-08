import 'package:flutter/material.dart';
import 'custom_theme.dart';
import 'custom_theme_data.dart';
import 'data/di/locator.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  await CustomThemeMode.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: CustomThemeMode.themeMode,
        builder: (context, themeMode, child) {
          return MaterialApp(
              title: 'MemoApp',
              home: MyAppPage(),
              darkTheme: CustomThemeData.dark,
              themeMode: themeMode,
              theme: CustomThemeData.light);
        });
  }
}
