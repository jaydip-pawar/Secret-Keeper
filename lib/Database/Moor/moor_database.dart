import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Passwords extends Table {
  IntColumn get id => integer()
      .autoIncrement()(); // autoIncrement automatically sets this to be the primary key
  TextColumn get wName => text()();
  TextColumn get wAddress => text()();
  TextColumn get uName => text()();
  TextColumn get password => text()();
  TextColumn get notes => text()();
}

class CardDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bName => text()();
  TextColumn get cName => text()();
  TextColumn get cNumber => text()();
  TextColumn get uName => text()();
  TextColumn get expiration => text()();
  TextColumn get cvv => text()();
  TextColumn get pin => text()();
  TextColumn get notes => text()();
}

class Banks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bName => text()();
  TextColumn get aNumber => text()();
  TextColumn get aType => text()();
  TextColumn get ifsc => text()();
  TextColumn get branchName => text()();
  TextColumn get branchAddress => text()();
  TextColumn get bNumber => text()();
  TextColumn get notes => text()();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get notes => text()();
  TextColumn get date => text()();
  TextColumn get time => text()();
}

@UseMoor(
    tables: [Passwords, CardDetails, Banks, Notes],
    daos: [PasswordDao, CardDetailDao, BankDao, NoteDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Passwords])
class PasswordDao extends DatabaseAccessor<AppDatabase>
    with _$PasswordDaoMixin {
  final AppDatabase db;

  PasswordDao(this.db) : super(db);

  Future<List<Password>> getAllPasswords() => select(passwords).get();
  Stream<List<Password>> watchAllPasswords() {
    return (select(passwords)
          ..orderBy([(t) => OrderingTerm(expression: t.wName)]))
        .watch();
  }

  Stream<List<Password>> watchSearchedPasswords(String query) {
    return customSelectStream('SELECT * FROM passwords WHERE INSTR(LOWER(w_name), LOWER(?1)) > 0 OR INSTR(LOWER(w_address), LOWER(?1)) > 0 ORDER BY w_name ASC ;',
      variables: [Variable.withString(query)],
      readsFrom: {passwords},).map((rows) {
        return rows.map((row) => Password.fromData(row.data, db)).toList();
      },
    );
  }

  Future insertPassword(Insertable<Password> password) =>
      into(passwords).insert(password);
  Future updatePassword(Insertable<Password> password) =>
      update(passwords).replace(password);
  Future deletePassword(Insertable<Password> password) =>
      delete(passwords).delete(password);
}

@UseDao(tables: [CardDetails])
class CardDetailDao extends DatabaseAccessor<AppDatabase>
    with _$CardDetailDaoMixin {
  final AppDatabase db;

  CardDetailDao(this.db) : super(db);

  Future<List<CardDetail>> getAllCards() => select(cardDetails).get();
  Stream<List<CardDetail>> watchAllCards() {
    return (select(cardDetails)
          ..orderBy([(t) => OrderingTerm(expression: t.cName)]))
        .watch();
  }

  Stream<List<CardDetail>> watchSearchedCards(String query) {
    return customSelectStream('SELECT * FROM card_details WHERE INSTR(LOWER(b_name), LOWER(?1)) > 0 OR INSTR(c_number, ?1) > 0 OR INSTR(c_name, ?1) > 0 ORDER BY b_name ASC ;',
      variables: [Variable.withString(query)],
      readsFrom: {cardDetails},).map((rows) {
      return rows.map((row) => CardDetail.fromData(row.data, db)).toList();
    },
    );
  }

  Future insertCardDetail(Insertable<CardDetail> cardDetail) =>
      into(cardDetails).insert(cardDetail);
  Future updateCardDetail(Insertable<CardDetail> cardDetail) =>
      update(cardDetails).replace(cardDetail);
  Future deleteCardDetail(Insertable<CardDetail> cardDetail) =>
      delete(cardDetails).delete(cardDetail);
}

@UseDao(tables: [Banks])
class BankDao extends DatabaseAccessor<AppDatabase> with _$BankDaoMixin {
  final AppDatabase db;

  BankDao(this.db) : super(db);

  Future<List<Bank>> getAllBanks() => select(banks).get();
  Stream<List<Bank>> watchAllBanks() {
    return (select(banks)..orderBy([(t) => OrderingTerm(expression: t.bName)]))
        .watch();
  }

  Stream<List<Bank>> watchSearchedBanks(String query) {
    return customSelectStream('SELECT * FROM banks WHERE INSTR(LOWER(b_name), LOWER(?1)) > 0 OR INSTR(a_number, ?1) > 0 ORDER BY b_name ASC ;',
      variables: [Variable.withString(query)],
      readsFrom: {banks},).map((rows) {
      return rows.map((row) => Bank.fromData(row.data, db)).toList();
    },
    );
  }

  Future insertBank(Insertable<Bank> bank) => into(banks).insert(bank);
  Future updateBank(Insertable<Bank> bank) => update(banks).replace(bank);
  Future deleteBank(Insertable<Bank> bank) => delete(banks).delete(bank);
}

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<AppDatabase> with _$NoteDaoMixin {
  final AppDatabase db;

  NoteDao(this.db) : super(db);

  Future<List<Note>> getAllNotes() => select(notes).get();
  Stream<List<Note>> watchAllNotes() {
    return (select(notes)..orderBy([(t) => OrderingTerm(expression: t.title)]))
        .watch();
  }

  Stream<List<Note>> watchSearchedNotes(String query) {
    return customSelectStream('SELECT * FROM notes WHERE INSTR(LOWER(title), LOWER(?1)) > 0 ORDER BY title ASC ;',
      variables: [Variable.withString(query)],
      readsFrom: {notes},).map((rows) {
      return rows.map((row) => Note.fromData(row.data, db)).toList();
    },
    );
  }

  Future insertNote(Insertable<Note> note) => into(notes).insert(note);
  Future updateNote(Insertable<Note> note) => update(notes).replace(note);
  Future deleteNote(Insertable<Note> note) => delete(notes).delete(note);
}
