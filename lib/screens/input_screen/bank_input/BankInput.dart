import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class BankInput extends StatefulWidget {
  @override
  _BankInputState createState() => _BankInputState();
}

class _BankInputState extends State<BankInput> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController branchAddressController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Widget bankName() {
    return CustomTextField(
      readOnly: false,
      controller: bankNameController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Bank Name",
      textInputAction: TextInputAction.next,
      validator: (bName) {
        if (bName.isEmpty || bName == null)
          return 'Bank name required!';
        else
          return null;
      },
    );
  }

  Widget accountNumber() {
    return CustomTextField(
      readOnly: false,
      controller: accountNumberController,
      textInputType: TextInputType.number,
      textCapitalization: TextCapitalization.none,
      label: "Account Number",
      textInputAction: TextInputAction.next,
      validator: (aNumber) {
        if (aNumber.isEmpty || aNumber == null)
          return 'Account Number required!';
        else
          return null;
      },
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

  void addDataToMoor() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        final bankDao = Provider.of<BankDao>(context);
        final bank = BanksCompanion(
          bName: Value(bankNameController.text),
          aNumber: Value(accountNumberController.text),
          aType: Value(accountTypeController.text),
          ifsc: Value(ifscController.text),
          branchName: Value(branchNameController.text),
          branchAddress: Value(branchAddressController.text),
          bNumber: Value(bankNumberController.text),
          notes: Value(notesController.text),
        );
        bankDao.insertBank(bank);
      });
      Navigator.pop(context);
    }
  }
}
