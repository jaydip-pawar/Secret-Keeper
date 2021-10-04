import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/lock_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:secret_keeper/screens/home_screen/Home.dart';
import 'package:flutter/services.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  String _password, _key = "Password";
  bool _isFingerprintEnabled;
  String _fingerprintKey = "isFingerprintEnabled";

  LocalAuthentication auth = LocalAuthentication();
  String authorized = "Not authorized";

  @override
  void initState() {
    // TODO: implement initState
    checkPassword();
    super.initState();
  }

  checkPassword() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _password = _preferences.getString(_key);
    _isFingerprintEnabled = _preferences.getBool(_fingerprintKey);
    showLockScreen(
      context: context,
      title: "Enter vault password",
      digits: 5,
      correctString: _password,
      cancelText: "Close",
      showBiometricFirst: _isFingerprintEnabled,
      canCancel: false,
      onUnlocked: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
        bool isRegistered = getIt.isRegistered<AutoLock>();
        if (isRegistered) {
          getIt.unregister<AutoLock>();
        }
        },
      canBiometric: _isFingerprintEnabled,
      biometricAuthenticate: (context) async {
        bool authenticated = false;
        try{
          authenticated = await auth.authenticateWithBiometrics(
            localizedReason: "Please authenticate",
            useErrorDialogs: true,
            stickyAuth: false,
          );
        } on PlatformException catch(e){
          print(e);
        }
        if(!mounted) return false;

        if (authenticated) {
          return true;
        }
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
      )
    );
  }
}
