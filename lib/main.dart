import 'package:contact_diary_7/home_page.dart';
import 'package:contact_diary_7/add_contact_page.dart';
import 'package:contact_diary_7/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        home: HomePage(
          changeTheme: () {
            isDark = !isDark;
            setState(() {});
          },
        ));
  }
}
