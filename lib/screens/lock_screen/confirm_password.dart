import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secret_keeper/Widgets/customTitleBar.dart';
import 'package:secret_keeper/Widgets/numeric_pad.dart';
import 'package:secret_keeper/dialog_boxes/custom_alert_dialog.dart';
import 'package:secret_keeper/screens/home_screen/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPassword extends StatefulWidget {
  final password;

  const ConfirmPassword({Key key, this.password}) : super(key: key);
  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {

  String _key = "isFirstTime";
  String _keyPass = "Password";

  String _password = "";
  bool _isEnabled = false;

  bool _isFingerprintEnabled = false;
  String _fingerprintKey = "isFingerprintEnabled";

  storeData(String password) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(_key, false);
    _preferences.setString(_keyPass, password);
    _preferences.setBool(_fingerprintKey, _isFingerprintEnabled);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Home()));
  }

  enableButton(){
    setState(() {
      _isEnabled = true;
    });
  }

  disableButton(){
    setState(() {
      _isEnabled = false;
    });
  }

  verifyPassword(){
    if(widget.password == _password){
      storeData(_password);
    }else
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CustomAlertDialog(
          title: "Incorrect Password",
          content:
          "The Password you entered is incorrect.\nPlease try again.",
          btnText: "OK",
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: cusTitleBar(),
        elevation: 2,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCodeNumberBox(
                              _password.length > 0 ? _password.substring(0, 1) : ""),
                          buildCodeNumberBox(
                              _password.length > 1 ? _password.substring(1, 2) : ""),
                          buildCodeNumberBox(
                              _password.length > 2 ? _password.substring(2, 3) : ""),
                          buildCodeNumberBox(
                              _password.length > 3 ? _password.substring(3, 4) : ""),
                          buildCodeNumberBox(
                              _password.length > 4 ? _password.substring(4, 5) : ""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: MediaQuery.of(context).size.height * 0.10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              child: FlatButton(
                onPressed: _isEnabled ? ()=> verifyPassword() : null,
                padding: EdgeInsets.all(0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xffff5f6d),
                        Color(0xffff5f6d),
                        Color(0xffffc371),
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, minHeight: 30),
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            NumericPad(
              onNumberSelected: (value) {
                // print(value);
                setState(
                      () {
                    if (value != -1) {
                      if (_password.length < 5) {
                        _password = _password + value.toString();
                      }
                    } else {
                      _password = _password.substring(0, _password.length - 1);
                    }
                    if(_password.length == 5)
                      enableButton();
                    if(_password.length < 5)
                      disableButton();
                    // print(code);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 45,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
