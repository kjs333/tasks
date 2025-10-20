import 'package:flutter/material.dart';
import 'package:tasks/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        cardColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[200]),
        scaffoldBackgroundColor: Colors.grey[400],
        dividerColor: Colors.grey[200],
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey[200],
          filled: true,
        ),
        primaryColor: Colors.grey[200],
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey[200],
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(color: Colors.grey, fontSize: 14),
          titleLarge: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decorationThickness: 0,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        cardColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
        scaffoldBackgroundColor: Colors.black,
        dividerColor: Colors.grey[900],
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey[900],
          filled: true,
        ),
        primaryColor: Colors.grey[900],
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey[900],
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.grey[200],
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(color: Colors.grey, fontSize: 14),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decorationThickness: 0,
          ),
        ),
      ),
      home: HomePage("KJS's Tasks"),
    );
  }
}
