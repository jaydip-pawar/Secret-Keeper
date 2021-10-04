import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/screens/input_screen/card_input/updateCard.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class ShowCardsData extends StatefulWidget {
  final CardDetail itemCardDetail;

  const ShowCardsData({Key key, this.itemCardDetail}) : super(key: key);

  @override
  _ShowCardsDataState createState() => _ShowCardsDataState();
}

class _ShowCardsDataState extends State<ShowCardsData> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureTextCVV = true, _obscureTextPIN = true;
  String _textToCopy;

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

  Widget bankName() {
    return CustomTextField(
      controller: bankNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Bank Name",
      readOnly: true,
      textInputAction: TextInputAction.next,
    );
  }

  Widget cardName() {
    return CustomTextField(
      controller: cardNameController,
      textInputType: null,
      textCapitalization: null,
      label: "Custom Card Name",
      readOnly: true,
      textInputAction: null,
    );
  }

  Widget cardNumber() {
    return CustomTextIconField(
      controller: cardNumberController,
      label: "Card Number",
      readOnly: true,
      icon: Icons.copy,
      onPressed: () {
        _textToCopy = cardNumberController.text;
        copyText(_textToCopy);
      },
    );
  }

  Widget cardholderName() {
    return CustomTextField(
      controller: userNameController,
      textInputType: null,
      textCapitalization: null,
      textInputAction: null,
      label: "Cardholder Name",
      readOnly: true,
    );
  }

  Widget expiration() {
    return CustomTextField(
      controller: expirationController,
      label: "Expiration",
      readOnly: true,
      textInputType: null,
      textCapitalization: null,
      textInputAction: null,
    );
  }

  Widget cVV() {
    return CustomTextIconsField(
      controller: cvvController,
      label: "CVV",
      obscureText: _obscureTextCVV,
      readOnly: true,
      onPressedCopy: () {
        _textToCopy = cvvController.text;
        copyText(_textToCopy);
      },
      onPressedEye: _toggleCVV,
    );
  }

  Widget pin() {
    return CustomTextIconsField(
      controller: pinController,
      label: "Pin",
      obscureText: _obscureTextPIN,
      readOnly: true,
      onPressedCopy: () {
        _textToCopy = pinController.text;
        copyText(_textToCopy);
      },
      onPressedEye: _togglePIN,
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
            title: Text("Card Details"),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    final itemCardDetail = widget.itemCardDetail;
                    _handleClick(value, itemCardDetail);
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
                    if (userNameController.text.isNotEmpty) cardholderName(),
                    if (userNameController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (expirationController.text.isNotEmpty) expiration(),
                    if (expirationController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (cvvController.text.isNotEmpty) cVV(),
                    if (cvvController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (pinController.text.isNotEmpty) pin(),
                    if (pinController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (notesController.text.isNotEmpty) note(),
                    if (notesController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
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

  void _handleClick(String value, itemCardDetail) {
    switch (value) {
      case 'Edit':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => UpdateCard(
                  itemCardDetail: itemCardDetail,
                )));
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
      case 'Delete':
        final dao = Provider.of<CardDetailDao>(context);
        dao.deleteCardDetail(itemCardDetail);
        Navigator.of(context).pop();
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
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
