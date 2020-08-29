import 'package:flutter/material.dart';
import 'package:nclock/models/my_theme_provider.dart';
import 'package:nclock/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyThemeModel(),
        child: Consumer<MyThemeModel>(
          builder: (context, theme, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NClock',
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            home: HomeScreen(),
          ),
        ));
  }
}
