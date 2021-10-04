import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key key,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;
  int generatePasswordHelper = 0;
  String _passwordStrength = "Hello";
  int _currentRangeValues = 6;
  final _formKey = GlobalKey<FormState>();

  TextEditingController websiteNameController = TextEditingController();
  TextEditingController websiteAddressController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget websiteName() {
    return CustomTextField(
      readOnly: false,
      controller: websiteNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Name of website",
      textInputAction: TextInputAction.next,
      validator: (wName) {
        if (wName.isEmpty || wName == null)
          return 'Website Name required!';
        else
          return null;
      },
    );
  }

  Widget websiteAddress() {
    return CustomTextField(
      readOnly: false,
      controller: websiteAddressController,
      textInputType: TextInputType.url,
      textCapitalization: TextCapitalization.none,
      label: "Website address",
      textInputAction: TextInputAction.next,
      validator: (wAddress) {
        if (wAddress.isEmpty || wAddress == null)
          return 'Website Address required!';
        else
          return null;
      },
    );
  }

  Widget userName() {
    return CustomTextField(
      readOnly: false,
      controller: userNameController,
      textInputType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      label: "Username / Email",
      textInputAction: TextInputAction.next,
    );
  }

  Widget inputPassword() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.text,
      obscureText: _obscureText,
      decoration: InputDecoration(
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
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey.shade600,
          ),
          onPressed: _toggle,
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget note() {
    return CustomNoteField(
      controller: notesController,
      label: "Notes",
      readOnly: false,
    );
  }

  Widget generatePassword() {
    this.generatePasswordHelper = 0;
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.deepOrange,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "GENERATE PASSWORD",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(
                    () {
                      generatePasswordHelper = 1;
                    },
                  );
                },
            )
          ],
        ),
      ),
    );
  }

  Widget passwordGenerator() {
    return Container(
      color: Colors.grey.shade200,
      width: MediaQuery.of(context).size.width / 1.1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  _passwordStrength,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    generatePasswordHelper = 0;
                  });
                },
              ),
            ],
          ),
          Slider(
              value: _currentRangeValues.toDouble(),
              min: 0,
              max: 100,
              divisions: 27,
              onChanged: (double newValue) {
                setState(() {
                  _currentRangeValues = newValue.round();
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()} dollars';
              })
        ],
      ),
    );
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Listener(
        onPointerDown: restartTimer,
        onPointerMove: restartTimer,
        onPointerUp: restartTimer,
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          //resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              new IconButton(
                icon: Icon(Icons.check),
                onPressed: addDataToMoor,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      websiteName(),
                      SizedBox(
                        height: 20,
                      ),
                      websiteAddress(),
                      SizedBox(
                        height: 20,
                      ),
                      userName(),
                      SizedBox(
                        height: 20,
                      ),
                      inputPassword(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (generatePasswordHelper == 0)
                            generatePassword()
                          else
                            passwordGenerator()
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      note(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addDataToMoor() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        final passwordDao = Provider.of<PasswordDao>(context);
        final password = PasswordsCompanion(
            wName: Value(websiteNameController.text),
            wAddress: Value(websiteAddressController.text),
            uName: Value(userNameController.text),
            password: Value(passwordController.text),
            notes: Value(notesController.text));
        passwordDao.insertPassword(password);
      });
      Navigator.pop(context);
    }
  }
}
