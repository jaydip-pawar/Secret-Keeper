import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:flutter/services.dart';
import 'package:secret_keeper/screens/input_screen/password_input/updatePassword.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class ShowPasswordsData extends StatefulWidget {
  final Password itemPassword;

  const ShowPasswordsData({Key key, this.itemPassword}) : super(key: key);
  @override
  _ShowPasswordsDataState createState() => _ShowPasswordsDataState();
}

class _ShowPasswordsDataState extends State<ShowPasswordsData> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  String _textToCopy;

  TextEditingController websiteNameController = TextEditingController();
  TextEditingController websiteAddressController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final itemPassword = widget.itemPassword;
    websiteNameController = TextEditingController(text: itemPassword.wName);
    websiteAddressController =
        TextEditingController(text: itemPassword.wAddress);
    userNameController = TextEditingController(text: itemPassword.uName);
    passwordController = TextEditingController(text: itemPassword.password);
    notesController = TextEditingController(text: itemPassword.notes);
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  void _toggle() {
    setState(
      () {
        _obscureText = !_obscureText;
      },
    );
  }

  Widget websiteName() {
    return CustomTextField(
      controller: websiteNameController,
      textInputType: null,
      textCapitalization: null,
      label: "Name of website",
      readOnly: true,
      textInputAction: null,
    );
  }

  Widget websiteAddress() {
    return CustomTextIconField(
      controller: websiteAddressController,
      label: "Website address",
      readOnly: true,
      icon: Icons.copy,
      onPressed: (){
        _textToCopy = websiteAddressController.text;
        copyText(_textToCopy);
      },
    );
  }

  Widget userName() {
    return CustomTextIconField(
      controller: userNameController,
      label: "Username / Email",
      readOnly: true,
      icon: Icons.copy,
      onPressed: (){
        _textToCopy = userNameController.text;
        copyText(_textToCopy);
      },
    );
  }

  Widget password() {
    return CustomTextIconsField(
      controller: passwordController,
      label: "Password",
      obscureText: _obscureText,
      readOnly: true,
      onPressedCopy: (){
        _textToCopy = passwordController.text;
        copyText(_textToCopy);
      },
      onPressedEye: _toggle,
    );
  }

  Widget note() {
    return CustomNoteField(
      controller: notesController,
      label: "Note",
      readOnly: true,
    );
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
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Passwords"),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    final itemPassword = widget.itemPassword;
                    _handleClick(value, itemPassword);
                  });
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Edit',
                    child: Container(
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Delete',
                    child: Container(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
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
                    if (userNameController.text.isNotEmpty)
                      userName(),
                    if (userNameController.text.isNotEmpty)
                      SizedBox(
                        height: 20,
                      ),
                    if (passwordController.text.isNotEmpty)
                      password(),
                    if (passwordController.text.isNotEmpty)
                      SizedBox(
                        height: 20,
                      ),
                    if (notesController.text.isNotEmpty)
                      note(),
                    if (notesController.text.isNotEmpty)
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
    );
  }

  void _handleClick(String value, itemPassword) {
    switch (value) {
      case 'Edit':
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => UpdatePassword(
                itemPassword: itemPassword,
              )
          )
        );
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
      case 'Delete':
        final dao = Provider.of<PasswordDao>(context);
        dao.deletePassword(itemPassword);
        Navigator.of(context).pop();
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        final snackBar = SnackBar(
          content: Text('Entry deleted!'),
          duration: Duration(seconds: 1),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
        break;
    }
  }

  void copyText(textToCopy) {
    Clipboard.setData(new ClipboardData(text: textToCopy));
    final snackBar = SnackBar(
      content: Text('Copied to Clipboard'),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
