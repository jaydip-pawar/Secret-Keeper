import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';

class UndoPassword {
  void undoDeletion(wName, wAddress, userName, password, notes, context) {
    final passwordDao = Provider.of<PasswordDao>(context);
    final values = PasswordsCompanion(
        wName: Value(wName),
        wAddress: Value(wAddress),
        uName: Value(userName),
        password: Value(password),
        notes: Value(notes));
    passwordDao.insertPassword(values);
  }
}

class UndoCard{
  void undoDeletion(bName, cName, cNumber, uName, expiration, cvv, pin, note, context) {
    final cardDetailDao = Provider.of<CardDetailDao>(context);
    final values = CardDetailsCompanion(
        bName: Value(bName),
        cName: Value(cName),
        cNumber: Value(cNumber),
        uName: Value(uName),
        expiration: Value(expiration),
        cvv: Value(cvv),
        pin: Value(pin),
        notes: Value(note));
    cardDetailDao.insertCardDetail(values);
  }
}

class UndoBank{
  void undoDeletion(bName, aNumber, aType, ifsc, branchName, branchAddress, bNumber, note, context) {
    final bankDao = Provider.of<BankDao>(context);
    final values = BanksCompanion(
        bName: Value(bName),
        aNumber: Value(aNumber),
        aType: Value(aType),
        ifsc: Value(ifsc),
        branchName: Value(branchName),
        branchAddress: Value(branchAddress),
        bNumber: Value(bNumber),
        notes: Value(note)
    );
    bankDao.insertBank(values);
  }
}

class UndoNote{
  void undoDeletion(title, note, date, time, context) {
    final noteDao = Provider.of<NoteDao>(context);
    final values = NotesCompanion(title: Value(title), notes: Value(note), date: Value(date), time: Value(time));
    noteDao.insertNote(values);
  }
}
