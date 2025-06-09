import 'package:flutter/material.dart';
import 'package:sarpras_management/home-page.dart';
import 'package:sarpras_management/home.dart';
import 'package:sarpras_management/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: HomeScreen(token: 'token',),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: CircleBorder(), // ✅ Paksa bentuk bulat
  ),
      ),

    );
  }
}