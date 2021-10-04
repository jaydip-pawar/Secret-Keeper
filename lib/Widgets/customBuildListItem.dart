import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/noItemAvailable.dart';
import 'package:secret_keeper/Widgets/stackBehindDismiss.dart';
import 'package:secret_keeper/screens/home_screen/passwords/showPasswordsData.dart';
import 'package:secret_keeper/screens/home_screen/cards/showCardsData.dart';
import 'package:secret_keeper/screens/home_screen/banks/showBanksData.dart';
import 'package:secret_keeper/screens/home_screen/notes/showNotesData.dart';
import 'package:secret_keeper/Widgets/undoDeletion.dart';

class BuildListPassword extends StatelessWidget {
  final passwords;

  const BuildListPassword({Key key, this.passwords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _wName, _wAddress, _userName, _password, _notes;
    final dao = Provider.of<PasswordDao>(context);
    return passwords.isEmpty ? NoItemAvailable(image: "assets/images/card.png", heading: "No passwords yet!", description: "Add your passwords to keep them in a single, organized location.",) : ListView.builder(
      itemCount: passwords.length,
      itemBuilder: (_, index) {
        final itemPassword = passwords[index];
        return Dismissible(
          background: StackBehindDismiss(),
          key: ObjectKey(itemPassword),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _wName = itemPassword.wName;
            _wAddress = itemPassword.wAddress;
            _userName = itemPassword.uName;
            _password = itemPassword.password;
            _notes = itemPassword.notes;
            dao.deletePassword(itemPassword);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Entry deleted!"),
                action: SnackBarAction(
                  label: "UNDO",
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () {
                    //To undo deletion
                    UndoPassword().undoDeletion(_wName, _wAddress, _userName,
                        _password, _notes, context);
                  },
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(
              itemPassword.wName,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            subtitle: Text(itemPassword.wAddress),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowPasswordsData(
                    itemPassword: itemPassword,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BuildListCard extends StatelessWidget {
  final cardDetails;

  const BuildListCard({Key key, this.cardDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _bName, _cName, _cNumber, _uName, _expiration, _cvv, _pin, _note;
    final dao = Provider.of<CardDetailDao>(context);

    return cardDetails.isEmpty ? NoItemAvailable(image: "assets/images/card.png", heading: "Time to shop!", description: "Tap \"+\" to add a credit card for faster online shopping. ",) : ListView.builder(
      itemCount: cardDetails.length,
      itemBuilder: (_, index) {
        final itemCardDetail = cardDetails[index];
        return Dismissible(
          background: StackBehindDismiss(),
          key: ObjectKey(itemCardDetail),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _bName = itemCardDetail.bName;
            _cName = itemCardDetail.cName;
            _cNumber = itemCardDetail.cNumber;
            _uName = itemCardDetail.uName;
            _expiration = itemCardDetail.expiration;
            _cvv = itemCardDetail.cvv;
            _pin = itemCardDetail.pin;
            _note = itemCardDetail.notes;
            dao.deleteCardDetail(itemCardDetail);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Entry deleted!"),
                action: SnackBarAction(
                  label: "UNDO",
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () {
                    //To undo deletion
                    UndoCard().undoDeletion(
                        _bName, _cName, _cNumber, _uName, _expiration, _cvv, _pin, _note, context);
                  },
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(
              itemCardDetail.bName,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            subtitle: Text(itemCardDetail.cName + ": " + itemCardDetail.cNumber),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowCardsData(
                    itemCardDetail: itemCardDetail,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BuildListBank extends StatelessWidget {
  final banks;

  const BuildListBank({Key key, this.banks}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _bName, _aNumber, _aType, _ifsc, _branchName, _branchAddress, _bNumber, _note;
    final dao = Provider.of<BankDao>(context);

    return banks.isEmpty ? NoItemAvailable(image: "assets/images/bank.png", heading: "No bank accounts!", description: "Add your bank details to keep them in a single, organized location",) : ListView.builder(
      itemCount: banks.length,
      itemBuilder: (_, index) {
        final itemBank = banks[index];
        return Dismissible(
          background: StackBehindDismiss(),
          key: ObjectKey(itemBank),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _bName = itemBank.bName;
            _aNumber = itemBank.aNumber;
            _aType = itemBank.aType;
            _ifsc = itemBank.ifsc;
            _branchName = itemBank.branchName;
            _branchAddress = itemBank.branchAddress;
            _bNumber = itemBank.bNumber;
            _note = itemBank.notes;
            dao.deleteBank(itemBank);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Entry deleted!"),
                action: SnackBarAction(
                  label: "UNDO",
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () {
                    //To undo deletion
                    UndoBank().undoDeletion(_bName, _aNumber, _aType, _ifsc, _branchName, _branchAddress, _bNumber, _note, context);
                  },
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(
              itemBank.bName,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            subtitle: Text(itemBank.aNumber),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowBanksData(
                    itemBank: itemBank,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BuildListNote extends StatelessWidget {
  final notes;

  const BuildListNote({Key key, this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _title, _note, _date, _time;
    final dao = Provider.of<NoteDao>(context);

    return notes.isEmpty ? NoItemAvailable(image: "assets/images/notes.png", heading: "No notes yet!", description: "Add notes to keep them in a single, organized location",) : ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) {
        final itemNote = notes[index];
        return Dismissible(
          background: StackBehindDismiss(),
          key: ObjectKey(itemNote),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _title = itemNote.title;
            _note = itemNote.notes;
            _date = itemNote.date;
            _time = itemNote.time;
            dao.deleteNote(itemNote);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Entry deleted!"),
                action: SnackBarAction(
                  label: "UNDO",
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () {
                    //To undo deletion
                    UndoNote().undoDeletion(_title, _note, _date, _time, context);
                  },
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(
              itemNote.title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            subtitle: Text("last updated " + itemNote.date + " " + itemNote.time),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowNotesData(
                    itemNote: itemNote,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

