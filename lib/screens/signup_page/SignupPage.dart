import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:secret_keeper/screens/login_page/LoginPage.dart';

class SignupPage extends StatefulWidget{

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String _name, _emailID, _password;
  bool _obscureText = true;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void _toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void validateSignup() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        final signUp = await _auth.createUserWithEmailAndPassword(
            email: _emailID,
            password: _password,
        );
        if(signUp != null)
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e);
      }
    }
  }

  Widget nameInput(){
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Full Name",
        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (name){

        if (name.isEmpty)
          return 'Please Enter your Name';
        else
          return null;
      },
      onSaved: (name)=> _name = name,
      textInputAction: TextInputAction.next,
    );
  }

  Widget emailInput(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email ID",
        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (email) {
        if (email.isEmpty)
          return 'Please Enter email ID';
        else if (!EmailValidator.validate(email))
          return 'Enter valid email address';
        else
          return null;
      },
      onSaved: (email)=> _emailID = email,
      textInputAction: TextInputAction.next,
    );
  }

  Widget passInput(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        errorMaxLines: 5,
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey.shade600,
          ),
          onPressed: _toggle,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (password){
        Pattern pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regex = new RegExp(pattern);
        if (password.isEmpty){
          return 'Please Enter Password';
        }else if (password.length < 8)
          return 'Password must be between 8 and 30 characters';
        else if (!regex.hasMatch(password))
          return 'Passwords must contain:\n  - at least 1 uppercase [A-Z]\n  - at least 1 lowercase [a-z]\n  - at least 1 number [0-9]\n  - at least 1 Special Character';
        else
          return null;
      },
      onSaved: (password)=> _password = password,
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 25,),
                      Text("Create Account,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                      SizedBox(height: 6,),
                      Text("Sign up to get started!",style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 40,),
                      nameInput(),
                      SizedBox(height: 16,),
                      emailInput(),
                      SizedBox(height: 16,),
                      passInput(),
                      SizedBox(height: 30,),
                      Container(
                        height: 50,
                        child: FlatButton(
                          onPressed: validateSignup,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xffff5f6d),
                                  Color(0xffff5f6d),
                                  Color(0xffffc371),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(minHeight: 50,maxWidth: double.infinity),
                              child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 96,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("I'm already a member.",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("Sign in.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
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