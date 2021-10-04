import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:secret_keeper/dialog_boxes/custom_alert_dialog.dart';
import 'package:secret_keeper/dialog_boxes/no_internet_dialog.dart';
import 'package:secret_keeper/screens/lock_screen/get_password.dart';
import 'package:secret_keeper/screens/signup_page/SignupPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _emailID, _password = "", _keyLogin = "isLogin";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void validateLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          try {
            UserCredential userCredential =
                await _auth.signInWithEmailAndPassword(
                    email: _emailID, password: _password);

            SharedPreferences _pref = await SharedPreferences.getInstance();
            _pref.setBool(_keyLogin, true);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => GetPassword()));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => CustomAlertDialog(
                  title: "Error",
                  content: "Your username or password is incorrect.",
                  btnText: "Try again",
                ),
              );
            } else if (e.code == 'wrong-password') {
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
            } else {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => CustomAlertDialog(
                  title: "Error",
                  content: "Something went wrong!.",
                  btnText: "Try again",
                ),
              );
            }
          }
        }
      } on SocketException catch (_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => NoInternetDialog(),
        );
      }
    }
  }

  void loginGoogle() async{
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      //Firebase SignIn
      final result = await _auth.signInWithCredential(credential);

      if (result != null){
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setBool(_keyLogin, true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => GetPassword()));
      }
    } catch (error) {
      print(error);
    }
  }

  Widget emailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email ID",
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red,
            )),
      ),
      validator: (email) {
        if (email.isEmpty)
          return 'Please Enter email ID';
        else if (!EmailValidator.validate(email))
          return 'Enter valid email address';
        else
          return null;
      },
      onSaved: (email) => _emailID = email,
      textInputAction: TextInputAction.next,
    );
  }

  Widget passInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        errorMaxLines: 5,
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red,
            )),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey.shade600,
          ),
          onPressed: _toggle,
        ),
      ),
      validator: (password) {
        Pattern pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regex = new RegExp(pattern);
        if (password.isEmpty) {
          return 'Please Enter Password';
        } else if (password.length < 8)
          return 'Password must be between 8 and 30 characters';
        else if (!regex.hasMatch(password))
          return 'Passwords must contain:\n  - at least 1 uppercase [A-Z]\n  - at least 1 lowercase [a-z]\n  - at least 1 number [0-9]\n  - at least 1 Special Character';
        else
          return null;
      },
      onSaved: (password) => _password = password,
      textInputAction: TextInputAction.done,
      obscureText: _obscureText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Welcome,",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Sign in to continue!",
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                      ),
                      emailInput(),
                      SizedBox(
                        height: 16,
                      ),
                      passInput(),
                      SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: validateLogin,
                          padding: EdgeInsets.all(0),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
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
                                  maxWidth: double.infinity, minHeight: 50),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Divider(
                                  height: 36,
                                )),
                          ),
                          Text("OR"),
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: Divider(
                                  height: 36,
                                )),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () {},
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image.asset("assets/icons/facebook.png",
                                  height: 25, width: 25),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                "Login with Facebook",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () {
                            loginGoogle();
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/icons/google.png",
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignupPage();
                            }));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
