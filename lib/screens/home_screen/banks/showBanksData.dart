import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/screens/input_screen/bank_input/updateBank.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class ShowBanksData extends StatefulWidget {
  final Bank itemBank;

  const ShowBanksData({Key key, this.itemBank}) : super(key: key);

  @override
  _ShowBanksDataState createState() => _ShowBanksDataState();
}

class _ShowBanksDataState extends State<ShowBanksData> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _textToCopy;

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController branchAddressController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final itemBank = widget.itemBank;
    bankNameController = TextEditingController(text: itemBank.bName);
    accountNumberController = TextEditingController(text: itemBank.aNumber);
    accountTypeController = TextEditingController(text: itemBank.aType);
    ifscController = TextEditingController(text: itemBank.ifsc);
    branchNameController = TextEditingController(text: itemBank.branchName);
    branchAddressController =
        TextEditingController(text: itemBank.branchAddress);
    bankNumberController = TextEditingController(text: itemBank.bNumber);
    notesController = TextEditingController(text: itemBank.notes);
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  Widget bankName() {
    return CustomTextField(
      controller: bankNameController,
      readOnly: true,
      label: "Bank Name",
      textInputType: null,
      textCapitalization: null,
      textInputAction: null,
    );
  }

  Widget accountNumber() {
    return CustomTextIconField(
      controller: accountNumberController,
      readOnly: true,
      label: "Account Number",
      icon: Icons.copy,
      onPressed: () {
        _textToCopy = accountNumberController.text;
        copyText(_textToCopy);
      },
    );
  }

  Widget accountType() {
    return CustomTextField(
      controller: accountTypeController,
      readOnly: true,
      label: "Account Type",
      textInputType: null,
      textCapitalization: null,
      textInputAction: null,
    );
  }

  Widget iFSC() {
    return CustomTextIconField(
      controller: ifscController,
      readOnly: true,
      label: "IFSC",
      icon: Icons.copy,
      onPressed: () {
        _textToCopy = ifscController.text;
        copyText(_textToCopy);
      },
    );
  }

  Widget branchName() {
    return CustomTextField(
      controller: branchNameController,
      readOnly: true,
      label: "Branch Name",
      textInputType: null,
      textCapitalization: null,
      textInputAction: null,
    );
  }

  Widget branchAddress() {
    return CustomTextField(
      controller: branchAddressController,
      readOnly: true,
      label: "Branch Address",
      textInputType: null,
      textCapitalization: null,
      textInputAction: null,
    );
  }

  Widget bankPhoneNumber() {
    return CustomTextIconField(
      controller: bankNumberController,
      readOnly: true,
      label: "Bank Phone Number",
      icon: Icons.copy,
      onPressed: () {
        _textToCopy = bankNumberController.text;
        copyText(_textToCopy);
      },
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
            title: Text("Bank Details"),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    final itemBank = widget.itemBank;
                    _handleClick(value, itemBank);
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
                    accountNumber(),
                    SizedBox(
                      height: 15,
                    ),
                    if (accountTypeController.text.isNotEmpty)
                      accountType(),
                    if (accountTypeController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (ifscController.text.isNotEmpty)
                      iFSC(),
                    if (ifscController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (branchNameController.text.isNotEmpty)
                      branchName(),
                    if (branchNameController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (branchAddressController.text.isNotEmpty)
                      branchAddress(),
                    if (branchAddressController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (bankNumberController.text.isNotEmpty)
                      bankPhoneNumber(),
                    if (bankNumberController.text.isNotEmpty)
                      SizedBox(
                        height: 15,
                      ),
                    if (notesController.text.isNotEmpty)
                      note(),
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

  void _handleClick(String value, itemBank) {
    switch (value) {
      case 'Edit':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => UpdateBank(
                  itemBank: itemBank,
                )));
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
      case 'Delete':
        final dao = Provider.of<BankDao>(context);
        dao.deleteBank(itemBank);
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
