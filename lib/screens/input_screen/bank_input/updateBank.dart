import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class UpdateBank extends StatefulWidget {
  final Bank itemBank;

  const UpdateBank({Key key, this.itemBank}) : super(key: key);
  @override
  _UpdateBankState createState() => _UpdateBankState();
}

class _UpdateBankState extends State<UpdateBank> {

  final _formKey = GlobalKey<FormState>();

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
    branchAddressController = TextEditingController(text: itemBank.branchAddress);
    bankNumberController = TextEditingController(text: itemBank.bNumber);
    notesController = TextEditingController(text: itemBank.notes);
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  Widget bankName() {
    return CustomTextField(
      readOnly: false,
      controller: bankNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Bank Name",
      validator: (bName) {
        if (bName.isEmpty || bName == null)
          return 'Bank name required!';
        else
          return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget accountNumber() {
    return CustomTextField(
      readOnly: false,
      controller: accountNumberController,
      textInputType: TextInputType.number,
      textCapitalization: TextCapitalization.none,
      label: "Account Number",
      validator: (aNumber) {
        if (aNumber.isEmpty || aNumber == null)
          return 'Account Number required!';
        else
          return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget accountType() {
    return CustomTextField(
      readOnly: false,
      controller: accountTypeController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Account Type",
      textInputAction: TextInputAction.next,
    );
  }

  Widget iFSC() {
    return CustomTextField(
      readOnly: false,
      controller: ifscController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      label: "IFSC",
      textInputAction: TextInputAction.next,
    );
  }

  Widget branchName() {
    return CustomTextField(
      readOnly: false,
      controller: branchNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Branch Name",
      textInputAction: TextInputAction.next,
    );
  }

  Widget branchAddress() {
    return CustomTextField(
      readOnly: false,
      controller: branchAddressController,
      textInputType: TextInputType.streetAddress,
      textCapitalization: TextCapitalization.words,
      label: "Branch Address",
      textInputAction: TextInputAction.next,
    );
  }

  Widget bankPhoneNumber() {
    return CustomTextField(
      readOnly: false,
      controller: bankNumberController,
      textInputType: TextInputType.number,
      textCapitalization: TextCapitalization.none,
      label: "Bank Phone Number",
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
                      accountNumber(),
                      SizedBox(
                        height: 15,
                      ),
                      accountType(),
                      SizedBox(
                        height: 15,
                      ),
                      iFSC(),
                      SizedBox(
                        height: 15,
                      ),
                      branchName(),
                      SizedBox(
                        height: 15,
                      ),
                      branchAddress(),
                      SizedBox(
                        height: 15,
                      ),
                      bankPhoneNumber(),
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
        final bankDao = Provider.of<BankDao>(context);
        final itemBank = widget.itemBank;
        final bank = BanksCompanion(
          id: Value(itemBank.id),
          bName: Value(bankNameController.text),
          aNumber: Value(accountNumberController.text),
          aType: Value(accountTypeController.text),
          ifsc: Value(ifscController.text),
          branchName: Value(branchNameController.text),
          branchAddress: Value(branchAddressController.text),
          bNumber: Value(bankNumberController.text),
          notes: Value(notesController.text),
        );
        bankDao.updateBank(bank);
      });
      int count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    }
  }
}
