import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secret_keeper/Widgets/numeric_pad.dart';
import 'package:secret_keeper/screens/lock_screen/confirm_password.dart';

class ChangeMasterPassword extends StatefulWidget {
  @override
  _ChangeMasterPasswordState createState() => _ChangeMasterPasswordState();
}

class _ChangeMasterPasswordState extends State<ChangeMasterPassword> {
  String password = "";
  bool isEnabled = false;

  enableButton() {
    setState(() {
      isEnabled = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Master Password"),
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
                    Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          "Enter current Master",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
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
                          buildCodeNumberBox(password.length > 0
                              ? password.substring(0, 1)
                              : ""),
                          buildCodeNumberBox(password.length > 1
                              ? password.substring(1, 2)
                              : ""),
                          buildCodeNumberBox(password.length > 2
                              ? password.substring(2, 3)
                              : ""),
                          buildCodeNumberBox(password.length > 3
                              ? password.substring(3, 4)
                              : ""),
                          buildCodeNumberBox(password.length > 4
                              ? password.substring(4, 5)
                              : ""),
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
                onPressed: isEnabled
                    ? () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ConfirmPassword(
                      password: password,
                    )))
                    : null,
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
                      "Enter current Master",
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
                      if (password.length < 5) {
                        password = password + value.toString();
                      }
                    } else {
                      password = password.substring(0, password.length - 1);
                    }
                    if (password.length == 5) enableButton();
                    if (password.length < 5) disableButton();
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
