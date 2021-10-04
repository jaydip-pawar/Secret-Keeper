import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:secret_keeper/dialog_boxes/rate_my_app.dart';
import 'package:secret_keeper/screens/lock_screen/authenticationScreen.dart';
import 'package:secret_keeper/screens/login_page/LoginPage.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';
import 'package:secret_keeper/screens/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _isFingerprintEnabled;
String _fingerprintKey = "isFingerprintEnabled";

class CustomPopupMenu extends StatelessWidget {

  void checkOnClick(int value, BuildContext context) {
    switch (value) {
      case 1:
        sync(context);
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
      case 2:
        settings().then((value) =>
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(isFingerprintEnabled: _isFingerprintEnabled))));
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
      case 3:
        rateUs(context);
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
      case 4:
        lockVault(context);
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
    }
  }

  void sync(BuildContext context) {

  }

  Future<void> settings() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _isFingerprintEnabled = _preferences.getBool(_fingerprintKey);
  }

  void rateUs(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => RateMyApp(),
    );
  }

  void lockVault(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authentication()));
  }

  void logout(BuildContext context) async{
    User user = FirebaseAuth.instance.currentUser;
    String loginType = user.providerData[0].providerId;

    if(loginType == "password")
      signOutFirebase().then((value) =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPage())),
      );
    else if(loginType == "google.com")
      signOutGoogle().then((value) =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPage())),
      );
  }

  Future<void> signOutFirebase() async {
    final _auth =FirebaseAuth.instance;
    await _auth.signOut();
    print("Sign Out");
  }

  Future<void> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    print("Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        checkOnClick(value, context);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Container(
            width: 100.0,
            child: Text(
              "Sync",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Container(
            width: 100.0,
            child: Text(
              "Settings",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Container(
            width: 100.0,
            child: Text(
              "Rate us",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Container(
            width: 100.0,
            child: Text(
              "Lock vault",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
