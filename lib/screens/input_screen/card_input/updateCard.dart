import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/screens/home_screen/Home.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class UpdateCard extends StatefulWidget {
  final CardDetail itemCardDetail;

  const UpdateCard({Key key, this.itemCardDetail}) : super(key: key);
  @override
  _UpdateCardState createState() => _UpdateCardState();
}

class _UpdateCardState extends State<UpdateCard> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final itemCardDetail = widget.itemCardDetail;
    bankNameController = TextEditingController(text: itemCardDetail.bName);
    cardNameController = TextEditingController(text: itemCardDetail.cName);
    cardNumberController = TextEditingController(text: itemCardDetail.cNumber);
    userNameController = TextEditingController(text: itemCardDetail.uName);
    expirationController = TextEditingController(text: itemCardDetail.expiration);
    cvvController = TextEditingController(text: itemCardDetail.cvv);
    pinController = TextEditingController(text: itemCardDetail.pin);
    notesController = TextEditingController(text: itemCardDetail.notes);
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

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

  Widget bankName(){
    return CustomTextField(
      controller: bankNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Bank Name",
      readOnly: false,
      validator: (bName) {
        if (bName.isEmpty || bName == null)
          return 'Bank name required!';
        else
          return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget cardName() {
    return CustomTextField(
      readOnly: false,
      controller: cardNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Custom Card Name",
      validator: (cName) {
        if (cName.isEmpty || cName == null)
          return 'Card name required!';
        else
          return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget cardNumber() {
    return CustomTextField(
      readOnly: false,
      controller: cardNumberController,
      textInputType: TextInputType.number,
      textCapitalization: TextCapitalization.none,
      label: "Card Number",
      validator: (cNumber) {
        if (cNumber.isEmpty || cNumber == null)
          return 'Card Number required!';
        else
          return null;
      },
      textInputAction: TextInputAction.next,
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
                onPressed: updateDataToMoor,
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

  void updateDataToMoor() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        final cardDetailDao = Provider.of<CardDetailDao>(context);
        final itemCardDetail = widget.itemCardDetail;
        final cardDetail = CardDetailsCompanion(
          id: Value(itemCardDetail.id),
          bName: Value(bankNameController.text),
          cName: Value(cardNameController.text),
          cNumber: Value(cardNumberController.text),
          uName: Value(userNameController.text),
          expiration: Value(expirationController.text),
          cvv: Value(cvvController.text),
          pin: Value(pinController.text),
          notes: Value(notesController.text),
        );
        cardDetailDao.updateCardDetail(cardDetail);
      });
      int count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    }
  }
}
