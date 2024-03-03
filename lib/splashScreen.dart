import 'package:flutter/material.dart';
import 'loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 4000));
    Navigator.pushReplacement(
      context,
      // MaterialPageRoute(builder: (context) => Home()),
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/receipes-bg.png",
          fit: BoxFit.fill,
        ),
        Text(
          "Makes your cooking easy",
          style: TextStyle(
              color: Colors.brown,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontFamily: 'Raleway'),),
      ],
    ));
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your home screen UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
