import 'package:contact_diary_7/add_contact_provider.dart';
import 'package:contact_diary_7/home_page.dart';
import 'package:contact_diary_7/add_contact_page.dart';
import 'package:contact_diary_7/theme.dart';
import 'package:contact_diary_7/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ContactProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          )
        ],
        builder: (context, child) => MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              themeMode: Provider.of<ThemeProvider>(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: HomePage(),
            ));
  }
}
