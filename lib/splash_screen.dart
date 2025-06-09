
import 'package:flutter/material.dart';
import 'package:sarpras_management/login.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[700], 
      body: Center(
        child: Image.asset(
          '../assets/images/logo-tb.png', 
          width: 350, 
          height: 350,
        ),
      ),
    );
  }
}