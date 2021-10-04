import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class CardInput extends StatefulWidget {
  @override
  _CardInputState createState() => _CardInputState();
}

class _CardInputState extends State<CardInput> {
  bool _obscureTextCVV = true, _obscureTextPIN = true;
  int checkField;
  final _formKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController expirationController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void _toggleCVV() {
    setState(() {
      _obscureTextCVV = !_obscureTextCVV;
    });
  }

  void _togglePIN() {
    setState(() {
      _obscureTextPIN = !_obscureTextPIN;
    });
  }

  Widget bankName() {
    return CustomTextField(
      controller: bankNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Bank Name",
      readOnly: false,
      textInputAction: TextInputAction.next,
      validator: (bName) {
        if (bName.isEmpty || bName == null)
          return 'Bank name required!';
        else
          return null;
      },
    );
  }

  Widget cardName() {
    return CustomTextField(
      readOnly: false,
      controller: cardNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Custom Card Name",
      textInputAction: TextInputAction.next,
      validator: (cName) {
        if (cName.isEmpty || cName == null)
          return 'Card name required!';
        else
          return null;
      },
    );
  }

  Widget cardNumber() {
    return CustomTextField(
      readOnly: false,
      controller: cardNumberController,
      textInputType: TextInputType.number,
      textCapitalization: TextCapitalization.none,
      label: "Card Number",
      textInputAction: TextInputAction.next,
      validator: (cNumber) {
        if (cNumber.isEmpty || cNumber == null)
          return 'Card Number required!';
        else
          return null;
      },
    );
  }

  Widget cardholderName() {
    return CustomTextField(
      readOnly: false,
      controller: userNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Cardholder Name",
      textInputAction: TextInputAction.next,
    );
  }

  Widget expiration() {
    return TextFormField(
      controller: expirationController,
      keyboardType: TextInputType.datetime,
      maxLength: 5,
      decoration: InputDecoration(
        labelText: "Expiration",
        counterText: "",
        hintText: "MM/DD",
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
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget cVV() {
    return TextFormField(
      controller: cvvController,
      keyboardType: TextInputType.datetime,
      maxLength: 3,
      obscureText: _obscureTextCVV,
      decoration: InputDecoration(
        counterText: "",
        labelText: "CVV",
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
            _obscureTextCVV ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey.shade600,
          ),
          onPressed: _toggleCVV,
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget pin() {
    return TextFormField(
      controller: pinController,
      keyboardType: TextInputType.number,
      obscureText: _obscureTextPIN,
      decoration: InputDecoration(
        labelText: "Pin",
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
            _obscureTextPIN ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey.shade600,
          ),
          onPressed: _togglePIN,
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
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      bankName(),
                      SizedBox(
                        height: 15,
                      ),
                      cardName(),
                      SizedBox(
                        height: 15,
                      ),
                      cardNumber(),
                      SizedBox(
                        height: 15,
                      ),
                      cardholderName(),
                      SizedBox(
                        height: 15,
                      ),
                      expiration(),
                      SizedBox(
                        height: 15,
                      ),
                      cVV(),
                      SizedBox(
                        height: 15,
                      ),
                      pin(),
                      SizedBox(
                        height: 15,
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
        final cardDetailDao = Provider.of<CardDetailDao>(context);
        final cardDetail = CardDetailsCompanion(
          bName: Value(bankNameController.text),
          cName: Value(cardNameController.text),
          cNumber: Value(cardNumberController.text),
          uName: Value(userNameController.text),
          expiration: Value(expirationController.text),
          cvv: Value(cvvController.text),
          pin: Value(pinController.text),
          notes: Value(notesController.text),
        );
        cardDetailDao.insertCardDetail(cardDetail);
      });
      Navigator.pop(context);
    }
  }
}
