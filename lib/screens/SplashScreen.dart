import 'dart:async';

import 'package:flutter/material.dart';
import 'package:secret_keeper/screens/lock_screen/authenticationScreen.dart';
import 'package:secret_keeper/screens/on_boarding_screen/OnboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String _key = "isFirstTime";
  bool _isFirstTime;

  @override
  void initState() {
    // TODO: implement initState
    checkFirstTime();
    super.initState();
  }

  checkFirstTime() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _isFirstTime = _pref.getBool(_key);

    if(_isFirstTime != null && _isFirstTime == false)
      Timer(Duration(seconds: 5),()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authentication())));
    else
      Timer(Duration(seconds: 5),()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen())));

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 50.0,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.greenAccent,
                          size: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
