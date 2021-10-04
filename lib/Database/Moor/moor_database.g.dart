// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Password extends DataClass implements Insertable<Password> {
  final int id;
  final String wName;
  final String wAddress;
  final String uName;
  final String password;
  final String notes;
  Password(
      {@required this.id,
      @required this.wName,
      @required this.wAddress,
      @required this.uName,
      @required this.password,
      @required this.notes});
  factory Password.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Password(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      wName:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}w_name']),
      wAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}w_address']),
      uName:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}u_name']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
    );
  }
  factory Password.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Password(
      id: serializer.fromJson<int>(json['id']),
      wName: serializer.fromJson<String>(json['wName']),
      wAddress: serializer.fromJson<String>(json['wAddress']),
      uName: serializer.fromJson<String>(json['uName']),
      password: serializer.fromJson<String>(json['password']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'wName': serializer.toJson<String>(wName),
      'wAddress': serializer.toJson<String>(wAddress),
      'uName': serializer.toJson<String>(uName),
      'password': serializer.toJson<String>(password),
      'notes': serializer.toJson<String>(notes),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Password>>(bool nullToAbsent) {
    return PasswordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      wName:
          wName == null && nullToAbsent ? const Value.absent() : Value(wName),
      wAddress: wAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(wAddress),
      uName:
          uName == null && nullToAbsent ? const Value.absent() : Value(uName),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    ) as T;
  }

  Password copyWith(
          {int id,
          String wName,
          String wAddress,
          String uName,
          String password,
          String notes}) =>
      Password(
        id: id ?? this.id,
        wName: wName ?? this.wName,
        wAddress: wAddress ?? this.wAddress,
        uName: uName ?? this.uName,
        password: password ?? this.password,
        notes: notes ?? this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('Password(')
          ..write('id: $id, ')
          ..write('wName: $wName, ')
          ..write('wAddress: $wAddress, ')
          ..write('uName: $uName, ')
          ..write('password: $password, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          wName.hashCode,
          $mrjc(
              wAddress.hashCode,
              $mrjc(
                  uName.hashCode, $mrjc(password.hashCode, notes.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Password &&
          other.id == id &&
          other.wName == wName &&
          other.wAddress == wAddress &&
          other.uName == uName &&
          other.password == password &&
          other.notes == notes);
}

class PasswordsCompanion extends UpdateCompanion<Password> {
  final Value<int> id;
  final Value<String> wName;
  final Value<String> wAddress;
  final Value<String> uName;
  final Value<String> password;
  final Value<String> notes;
  const PasswordsCompanion({
    this.id = const Value.absent(),
    this.wName = const Value.absent(),
    this.wAddress = const Value.absent(),
    this.uName = const Value.absent(),
    this.password = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PasswordsCompanion copyWith(
      {Value<int> id,
      Value<String> wName,
      Value<String> wAddress,
      Value<String> uName,
      Value<String> password,
      Value<String> notes}) {
    return PasswordsCompanion(
      id: id ?? this.id,
      wName: wName ?? this.wName,
      wAddress: wAddress ?? this.wAddress,
      uName: uName ?? this.uName,
      password: password ?? this.password,
      notes: notes ?? this.notes,
    );
  }
}

class $PasswordsTable extends Passwords
    with TableInfo<$PasswordsTable, Password> {
  final GeneratedDatabase _db;
  final String _alias;
  $PasswordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _wNameMeta = const VerificationMeta('wName');
  GeneratedTextColumn _wName;
  @override
  GeneratedTextColumn get wName => _wName ??= _constructWName();
  GeneratedTextColumn _constructWName() {
    return GeneratedTextColumn(
      'w_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _wAddressMeta = const VerificationMeta('wAddress');
  GeneratedTextColumn _wAddress;
  @override
  GeneratedTextColumn get wAddress => _wAddress ??= _constructWAddress();
  GeneratedTextColumn _constructWAddress() {
    return GeneratedTextColumn(
      'w_address',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uNameMeta = const VerificationMeta('uName');
  GeneratedTextColumn _uName;
  @override
  GeneratedTextColumn get uName => _uName ??= _constructUName();
  GeneratedTextColumn _constructUName() {
    return GeneratedTextColumn(
      'u_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, wName, wAddress, uName, password, notes];
  @override
  $PasswordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'passwords';
  @override
  final String actualTableName = 'passwords';
  @override
  VerificationContext validateIntegrity(PasswordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.wName.present) {
      context.handle(
          _wNameMeta, wName.isAcceptableValue(d.wName.value, _wNameMeta));
    } else if (wName.isRequired && isInserting) {
      context.missing(_wNameMeta);
    }
    if (d.wAddress.present) {
      context.handle(_wAddressMeta,
          wAddress.isAcceptableValue(d.wAddress.value, _wAddressMeta));
    } else if (wAddress.isRequired && isInserting) {
      context.missing(_wAddressMeta);
    }
    if (d.uName.present) {
      context.handle(
          _uNameMeta, uName.isAcceptableValue(d.uName.value, _uNameMeta));
    } else if (uName.isRequired && isInserting) {
      context.missing(_uNameMeta);
    }
    if (d.password.present) {
      context.handle(_passwordMeta,
          password.isAcceptableValue(d.password.value, _passwordMeta));
    } else if (password.isRequired && isInserting) {
      context.missing(_passwordMeta);
    }
    if (d.notes.present) {
      context.handle(
          _notesMeta, notes.isAcceptableValue(d.notes.value, _notesMeta));
    } else if (notes.isRequired && isInserting) {
      context.missing(_notesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Password map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Password.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PasswordsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.wName.present) {
      map['w_name'] = Variable<String, StringType>(d.wName.value);
    }
    if (d.wAddress.present) {
      map['w_address'] = Variable<String, StringType>(d.wAddress.value);
    }
    if (d.uName.present) {
      map['u_name'] = Variable<String, StringType>(d.uName.value);
    }
    if (d.password.present) {
      map['password'] = Variable<String, StringType>(d.password.value);
    }
    if (d.notes.present) {
      map['notes'] = Variable<String, StringType>(d.notes.value);
    }
    return map;
  }

  @override
  $PasswordsTable createAlias(String alias) {
    return $PasswordsTable(_db, alias);
  }
}

class CardDetail extends DataClass implements Insertable<CardDetail> {
  final int id;
  final String bName;
  final String cName;
  final String cNumber;
  final String uName;
  final String expiration;
  final String cvv;
  final String pin;
  final String notes;
  CardDetail(
      {@required this.id,
      @required this.bName,
      @required this.cName,
      @required this.cNumber,
      @required this.uName,
      @required this.expiration,
      @required this.cvv,
      @required this.pin,
      @required this.notes});
  factory CardDetail.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return CardDetail(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      bName:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}b_name']),
      cName:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}c_name']),
      cNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}c_number']),
      uName:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}u_name']),
      expiration: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expiration']),
      cvv: stringType.mapFromDatabaseResponse(data['${effectivePrefix}cvv']),
      pin: stringType.mapFromDatabaseResponse(data['${effectivePrefix}pin']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
    );
  }
  factory CardDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CardDetail(
      id: serializer.fromJson<int>(json['id']),
      bName: serializer.fromJson<String>(json['bName']),
      cName: serializer.fromJson<String>(json['cName']),
      cNumber: serializer.fromJson<String>(json['cNumber']),
      uName: serializer.fromJson<String>(json['uName']),
      expiration: serializer.fromJson<String>(json['expiration']),
      cvv: serializer.fromJson<String>(json['cvv']),
      pin: serializer.fromJson<String>(json['pin']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'bName': serializer.toJson<String>(bName),
      'cName': serializer.toJson<String>(cName),
      'cNumber': serializer.toJson<String>(cNumber),
      'uName': serializer.toJson<String>(uName),
      'expiration': serializer.toJson<String>(expiration),
      'cvv': serializer.toJson<String>(cvv),
      'pin': serializer.toJson<String>(pin),
      'notes': serializer.toJson<String>(notes),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CardDetail>>(bool nullToAbsent) {
    return CardDetailsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      bName:
          bName == null && nullToAbsent ? const Value.absent() : Value(bName),
      cName:
          cName == null && nullToAbsent ? const Value.absent() : Value(cName),
      cNumber: cNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(cNumber),
      uName:
          uName == null && nullToAbsent ? const Value.absent() : Value(uName),
      expiration: expiration == null && nullToAbsent
          ? const Value.absent()
          : Value(expiration),
      cvv: cvv == null && nullToAbsent ? const Value.absent() : Value(cvv),
      pin: pin == null && nullToAbsent ? const Value.absent() : Value(pin),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    ) as T;
  }

  CardDetail copyWith(
          {int id,
          String bName,
          String cName,
          String cNumber,
          String uName,
          String expiration,
          String cvv,
          String pin,
          String notes}) =>
      CardDetail(
        id: id ?? this.id,
        bName: bName ?? this.bName,
        cName: cName ?? this.cName,
        cNumber: cNumber ?? this.cNumber,
        uName: uName ?? this.uName,
        expiration: expiration ?? this.expiration,
        cvv: cvv ?? this.cvv,
        pin: pin ?? this.pin,
        notes: notes ?? this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('CardDetail(')
          ..write('id: $id, ')
          ..write('bName: $bName, ')
          ..write('cName: $cName, ')
          ..write('cNumber: $cNumber, ')
          ..write('uName: $uName, ')
          ..write('expiration: $expiration, ')
          ..write('cvv: $cvv, ')
          ..write('pin: $pin, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          bName.hashCode,
          $mrjc(
              cName.hashCode,
              $mrjc(
                  cNumber.hashCode,
                  $mrjc(
                      uName.hashCode,
                      $mrjc(
                          expiration.hashCode,
                          $mrjc(cvv.hashCode,
                              $mrjc(pin.hashCode, notes.hashCode)))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CardDetail &&
          other.id == id &&
          other.bName == bName &&
          other.cName == cName &&
          other.cNumber == cNumber &&
          other.uName == uName &&
          other.expiration == expiration &&
          other.cvv == cvv &&
          other.pin == pin &&
          other.notes == notes);
}

class CardDetailsCompanion extends UpdateCompanion<CardDetail> {
  final Value<int> id;
  final Value<String> bName;
  final Value<String> cName;
  final Value<String> cNumber;
  final Value<String> uName;
  final Value<String> expiration;
  final Value<String> cvv;
  final Value<String> pin;
  final Value<String> notes;
  const CardDetailsCompanion({
    this.id = const Value.absent(),
    this.bName = const Value.absent(),
    this.cName = const Value.absent(),
    this.cNumber = const Value.absent(),
    this.uName = const Value.absent(),
    this.expiration = const Value.absent(),
    this.cvv = const Value.absent(),
    this.pin = const Value.absent(),
    this.notes = const Value.absent(),
  });
  CardDetailsCompanion copyWith(
      {Value<int> id,
      Value<String> bName,
      Value<String> cName,
      Value<String> cNumber,
      Value<String> uName,
      Value<String> expiration,
      Value<String> cvv,
      Value<String> pin,
      Value<String> notes}) {
    return CardDetailsCompanion(
      id: id ?? this.id,
      bName: bName ?? this.bName,
      cName: cName ?? this.cName,
      cNumber: cNumber ?? this.cNumber,
      uName: uName ?? this.uName,
      expiration: expiration ?? this.expiration,
      cvv: cvv ?? this.cvv,
      pin: pin ?? this.pin,
      notes: notes ?? this.notes,
    );
  }
}

class $CardDetailsTable extends CardDetails
    with TableInfo<$CardDetailsTable, CardDetail> {
  final GeneratedDatabase _db;
  final String _alias;
  $CardDetailsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _bNameMeta = const VerificationMeta('bName');
  GeneratedTextColumn _bName;
  @override
  GeneratedTextColumn get bName => _bName ??= _constructBName();
  GeneratedTextColumn _constructBName() {
    return GeneratedTextColumn(
      'b_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cNameMeta = const VerificationMeta('cName');
  GeneratedTextColumn _cName;
  @override
  GeneratedTextColumn get cName => _cName ??= _constructCName();
  GeneratedTextColumn _constructCName() {
    return GeneratedTextColumn(
      'c_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cNumberMeta = const VerificationMeta('cNumber');
  GeneratedTextColumn _cNumber;
  @override
  GeneratedTextColumn get cNumber => _cNumber ??= _constructCNumber();
  GeneratedTextColumn _constructCNumber() {
    return GeneratedTextColumn(
      'c_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uNameMeta = const VerificationMeta('uName');
  GeneratedTextColumn _uName;
  @override
  GeneratedTextColumn get uName => _uName ??= _constructUName();
  GeneratedTextColumn _constructUName() {
    return GeneratedTextColumn(
      'u_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _expirationMeta = const VerificationMeta('expiration');
  GeneratedTextColumn _expiration;
  @override
  GeneratedTextColumn get expiration => _expiration ??= _constructExpiration();
  GeneratedTextColumn _constructExpiration() {
    return GeneratedTextColumn(
      'expiration',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cvvMeta = const VerificationMeta('cvv');
  GeneratedTextColumn _cvv;
  @override
  GeneratedTextColumn get cvv => _cvv ??= _constructCvv();
  GeneratedTextColumn _constructCvv() {
    return GeneratedTextColumn(
      'cvv',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pinMeta = const VerificationMeta('pin');
  GeneratedTextColumn _pin;
  @override
  GeneratedTextColumn get pin => _pin ??= _constructPin();
  GeneratedTextColumn _constructPin() {
    return GeneratedTextColumn(
      'pin',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, bName, cName, cNumber, uName, expiration, cvv, pin, notes];
  @override
  $CardDetailsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'card_details';
  @override
  final String actualTableName = 'card_details';
  @override
  VerificationContext validateIntegrity(CardDetailsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.bName.present) {
      context.handle(
          _bNameMeta, bName.isAcceptableValue(d.bName.value, _bNameMeta));
    } else if (bName.isRequired && isInserting) {
      context.missing(_bNameMeta);
    }
    if (d.cName.present) {
      context.handle(
          _cNameMeta, cName.isAcceptableValue(d.cName.value, _cNameMeta));
    } else if (cName.isRequired && isInserting) {
      context.missing(_cNameMeta);
    }
    if (d.cNumber.present) {
      context.handle(_cNumberMeta,
          cNumber.isAcceptableValue(d.cNumber.value, _cNumberMeta));
    } else if (cNumber.isRequired && isInserting) {
      context.missing(_cNumberMeta);
    }
    if (d.uName.present) {
      context.handle(
          _uNameMeta, uName.isAcceptableValue(d.uName.value, _uNameMeta));
    } else if (uName.isRequired && isInserting) {
      context.missing(_uNameMeta);
    }
    if (d.expiration.present) {
      context.handle(_expirationMeta,
          expiration.isAcceptableValue(d.expiration.value, _expirationMeta));
    } else if (expiration.isRequired && isInserting) {
      context.missing(_expirationMeta);
    }
    if (d.cvv.present) {
      context.handle(_cvvMeta, cvv.isAcceptableValue(d.cvv.value, _cvvMeta));
    } else if (cvv.isRequired && isInserting) {
      context.missing(_cvvMeta);
    }
    if (d.pin.present) {
      context.handle(_pinMeta, pin.isAcceptableValue(d.pin.value, _pinMeta));
    } else if (pin.isRequired && isInserting) {
      context.missing(_pinMeta);
    }
    if (d.notes.present) {
      context.handle(
          _notesMeta, notes.isAcceptableValue(d.notes.value, _notesMeta));
    } else if (notes.isRequired && isInserting) {
      context.missing(_notesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardDetail map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CardDetail.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CardDetailsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.bName.present) {
      map['b_name'] = Variable<String, StringType>(d.bName.value);
    }
    if (d.cName.present) {
      map['c_name'] = Variable<String, StringType>(d.cName.value);
    }
    if (d.cNumber.present) {
      map['c_number'] = Variable<String, StringType>(d.cNumber.value);
    }
    if (d.uName.present) {
      map['u_name'] = Variable<String, StringType>(d.uName.value);
    }
    if (d.expiration.present) {
      map['expiration'] = Variable<String, StringType>(d.expiration.value);
    }
    if (d.cvv.present) {
      map['cvv'] = Variable<String, StringType>(d.cvv.value);
    }
    if (d.pin.present) {
      map['pin'] = Variable<String, StringType>(d.pin.value);
    }
    if (d.notes.present) {
      map['notes'] = Variable<String, StringType>(d.notes.value);
    }
    return map;
  }

  @override
  $CardDetailsTable createAlias(String alias) {
    return $CardDetailsTable(_db, alias);
  }
}

class Bank extends DataClass implements Insertable<Bank> {
  final int id;
  final String bName;
  final String aNumber;
  final String aType;
  final String ifsc;
  final String branchName;
  final String branchAddress;
  final String bNumber;
  final String notes;
  Bank(
      {@required this.id,
      @required this.bName,
      @required this.aNumber,
      @required this.aType,
      @required this.ifsc,
      @required this.branchName,
      @required this.branchAddress,
      @required this.bNumber,
      @required this.notes});
  factory Bank.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Bank(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      bName:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}b_name']),
      aNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}a_number']),
      aType:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}a_type']),
      ifsc: stringType.mapFromDatabaseResponse(data['${effectivePrefix}ifsc']),
      branchName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}branch_name']),
      branchAddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}branch_address']),
      bNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}b_number']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
    );
  }
  factory Bank.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Bank(
      id: serializer.fromJson<int>(json['id']),
      bName: serializer.fromJson<String>(json['bName']),
      aNumber: serializer.fromJson<String>(json['aNumber']),
      aType: serializer.fromJson<String>(json['aType']),
      ifsc: serializer.fromJson<String>(json['ifsc']),
      branchName: serializer.fromJson<String>(json['branchName']),
      branchAddress: serializer.fromJson<String>(json['branchAddress']),
      bNumber: serializer.fromJson<String>(json['bNumber']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'bName': serializer.toJson<String>(bName),
      'aNumber': serializer.toJson<String>(aNumber),
      'aType': serializer.toJson<String>(aType),
      'ifsc': serializer.toJson<String>(ifsc),
      'branchName': serializer.toJson<String>(branchName),
      'branchAddress': serializer.toJson<String>(branchAddress),
      'bNumber': serializer.toJson<String>(bNumber),
      'notes': serializer.toJson<String>(notes),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Bank>>(bool nullToAbsent) {
    return BanksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      bName:
          bName == null && nullToAbsent ? const Value.absent() : Value(bName),
      aNumber: aNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(aNumber),
      aType:
          aType == null && nullToAbsent ? const Value.absent() : Value(aType),
      ifsc: ifsc == null && nullToAbsent ? const Value.absent() : Value(ifsc),
      branchName: branchName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchName),
      branchAddress: branchAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(branchAddress),
      bNumber: bNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(bNumber),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    ) as T;
  }

  Bank copyWith(
          {int id,
          String bName,
          String aNumber,
          String aType,
          String ifsc,
          String branchName,
          String branchAddress,
          String bNumber,
          String notes}) =>
      Bank(
        id: id ?? this.id,
        bName: bName ?? this.bName,
        aNumber: aNumber ?? this.aNumber,
        aType: aType ?? this.aType,
        ifsc: ifsc ?? this.ifsc,
        branchName: branchName ?? this.branchName,
        branchAddress: branchAddress ?? this.branchAddress,
        bNumber: bNumber ?? this.bNumber,
        notes: notes ?? this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('Bank(')
          ..write('id: $id, ')
          ..write('bName: $bName, ')
          ..write('aNumber: $aNumber, ')
          ..write('aType: $aType, ')
          ..write('ifsc: $ifsc, ')
          ..write('branchName: $branchName, ')
          ..write('branchAddress: $branchAddress, ')
          ..write('bNumber: $bNumber, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          bName.hashCode,
          $mrjc(
              aNumber.hashCode,
              $mrjc(
                  aType.hashCode,
                  $mrjc(
                      ifsc.hashCode,
                      $mrjc(
                          branchName.hashCode,
                          $mrjc(branchAddress.hashCode,
                              $mrjc(bNumber.hashCode, notes.hashCode)))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Bank &&
          other.id == id &&
          other.bName == bName &&
          other.aNumber == aNumber &&
          other.aType == aType &&
          other.ifsc == ifsc &&
          other.branchName == branchName &&
          other.branchAddress == branchAddress &&
          other.bNumber == bNumber &&
          other.notes == notes);
}

class BanksCompanion extends UpdateCompanion<Bank> {
  final Value<int> id;
  final Value<String> bName;
  final Value<String> aNumber;
  final Value<String> aType;
  final Value<String> ifsc;
  final Value<String> branchName;
  final Value<String> branchAddress;
  final Value<String> bNumber;
  final Value<String> notes;
  const BanksCompanion({
    this.id = const Value.absent(),
    this.bName = const Value.absent(),
    this.aNumber = const Value.absent(),
    this.aType = const Value.absent(),
    this.ifsc = const Value.absent(),
    this.branchName = const Value.absent(),
    this.branchAddress = const Value.absent(),
    this.bNumber = const Value.absent(),
    this.notes = const Value.absent(),
  });
  BanksCompanion copyWith(
      {Value<int> id,
      Value<String> bName,
      Value<String> aNumber,
      Value<String> aType,
      Value<String> ifsc,
      Value<String> branchName,
      Value<String> branchAddress,
      Value<String> bNumber,
      Value<String> notes}) {
    return BanksCompanion(
      id: id ?? this.id,
      bName: bName ?? this.bName,
      aNumber: aNumber ?? this.aNumber,
      aType: aType ?? this.aType,
      ifsc: ifsc ?? this.ifsc,
      branchName: branchName ?? this.branchName,
      branchAddress: branchAddress ?? this.branchAddress,
      bNumber: bNumber ?? this.bNumber,
      notes: notes ?? this.notes,
    );
  }
}

class $BanksTable extends Banks with TableInfo<$BanksTable, Bank> {
  final GeneratedDatabase _db;
  final String _alias;
  $BanksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _bNameMeta = const VerificationMeta('bName');
  GeneratedTextColumn _bName;
  @override
  GeneratedTextColumn get bName => _bName ??= _constructBName();
  GeneratedTextColumn _constructBName() {
    return GeneratedTextColumn(
      'b_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _aNumberMeta = const VerificationMeta('aNumber');
  GeneratedTextColumn _aNumber;
  @override
  GeneratedTextColumn get aNumber => _aNumber ??= _constructANumber();
  GeneratedTextColumn _constructANumber() {
    return GeneratedTextColumn(
      'a_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _aTypeMeta = const VerificationMeta('aType');
  GeneratedTextColumn _aType;
  @override
  GeneratedTextColumn get aType => _aType ??= _constructAType();
  GeneratedTextColumn _constructAType() {
    return GeneratedTextColumn(
      'a_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ifscMeta = const VerificationMeta('ifsc');
  GeneratedTextColumn _ifsc;
  @override
  GeneratedTextColumn get ifsc => _ifsc ??= _constructIfsc();
  GeneratedTextColumn _constructIfsc() {
    return GeneratedTextColumn(
      'ifsc',
      $tableName,
      false,
    );
  }

  final VerificationMeta _branchNameMeta = const VerificationMeta('branchName');
  GeneratedTextColumn _branchName;
  @override
  GeneratedTextColumn get branchName => _branchName ??= _constructBranchName();
  GeneratedTextColumn _constructBranchName() {
    return GeneratedTextColumn(
      'branch_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _branchAddressMeta =
      const VerificationMeta('branchAddress');
  GeneratedTextColumn _branchAddress;
  @override
  GeneratedTextColumn get branchAddress =>
      _branchAddress ??= _constructBranchAddress();
  GeneratedTextColumn _constructBranchAddress() {
    return GeneratedTextColumn(
      'branch_address',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bNumberMeta = const VerificationMeta('bNumber');
  GeneratedTextColumn _bNumber;
  @override
  GeneratedTextColumn get bNumber => _bNumber ??= _constructBNumber();
  GeneratedTextColumn _constructBNumber() {
    return GeneratedTextColumn(
      'b_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        bName,
        aNumber,
        aType,
        ifsc,
        branchName,
        branchAddress,
        bNumber,
        notes
      ];
  @override
  $BanksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'banks';
  @override
  final String actualTableName = 'banks';
  @override
  VerificationContext validateIntegrity(BanksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.bName.present) {
      context.handle(
          _bNameMeta, bName.isAcceptableValue(d.bName.value, _bNameMeta));
    } else if (bName.isRequired && isInserting) {
      context.missing(_bNameMeta);
    }
    if (d.aNumber.present) {
      context.handle(_aNumberMeta,
          aNumber.isAcceptableValue(d.aNumber.value, _aNumberMeta));
    } else if (aNumber.isRequired && isInserting) {
      context.missing(_aNumberMeta);
    }
    if (d.aType.present) {
      context.handle(
          _aTypeMeta, aType.isAcceptableValue(d.aType.value, _aTypeMeta));
    } else if (aType.isRequired && isInserting) {
      context.missing(_aTypeMeta);
    }
    if (d.ifsc.present) {
      context.handle(
          _ifscMeta, ifsc.isAcceptableValue(d.ifsc.value, _ifscMeta));
    } else if (ifsc.isRequired && isInserting) {
      context.missing(_ifscMeta);
    }
    if (d.branchName.present) {
      context.handle(_branchNameMeta,
          branchName.isAcceptableValue(d.branchName.value, _branchNameMeta));
    } else if (branchName.isRequired && isInserting) {
      context.missing(_branchNameMeta);
    }
    if (d.branchAddress.present) {
      context.handle(
          _branchAddressMeta,
          branchAddress.isAcceptableValue(
              d.branchAddress.value, _branchAddressMeta));
    } else if (branchAddress.isRequired && isInserting) {
      context.missing(_branchAddressMeta);
    }
    if (d.bNumber.present) {
      context.handle(_bNumberMeta,
          bNumber.isAcceptableValue(d.bNumber.value, _bNumberMeta));
    } else if (bNumber.isRequired && isInserting) {
      context.missing(_bNumberMeta);
    }
    if (d.notes.present) {
      context.handle(
          _notesMeta, notes.isAcceptableValue(d.notes.value, _notesMeta));
    } else if (notes.isRequired && isInserting) {
      context.missing(_notesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bank map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Bank.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(BanksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.bName.present) {
      map['b_name'] = Variable<String, StringType>(d.bName.value);
    }
    if (d.aNumber.present) {
      map['a_number'] = Variable<String, StringType>(d.aNumber.value);
    }
    if (d.aType.present) {
      map['a_type'] = Variable<String, StringType>(d.aType.value);
    }
    if (d.ifsc.present) {
      map['ifsc'] = Variable<String, StringType>(d.ifsc.value);
    }
    if (d.branchName.present) {
      map['branch_name'] = Variable<String, StringType>(d.branchName.value);
    }
    if (d.branchAddress.present) {
      map['branch_address'] =
          Variable<String, StringType>(d.branchAddress.value);
    }
    if (d.bNumber.present) {
      map['b_number'] = Variable<String, StringType>(d.bNumber.value);
    }
    if (d.notes.present) {
      map['notes'] = Variable<String, StringType>(d.notes.value);
    }
    return map;
  }

  @override
  $BanksTable createAlias(String alias) {
    return $BanksTable(_db, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String title;
  final String notes;
  final String date;
  final String time;
  Note(
      {@required this.id,
      @required this.title,
      @required this.notes,
      @required this.date,
      @required this.time});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      time: stringType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Note(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      date: serializer.fromJson<String>(json['date']),
      time: serializer.fromJson<String>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'date': serializer.toJson<String>(date),
      'time': serializer.toJson<String>(time),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Note>>(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
    ) as T;
  }

  Note copyWith(
          {int id, String title, String notes, String date, String time}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        notes: notes ?? this.notes,
        date: date ?? this.date,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('date: $date, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(title.hashCode,
          $mrjc(notes.hashCode, $mrjc(date.hashCode, time.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == id &&
          other.title == title &&
          other.notes == notes &&
          other.date == date &&
          other.time == time);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> notes;
  final Value<String> date;
  final Value<String> time;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
  });
  NotesCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> notes,
      Value<String> date,
      Value<String> time}) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedTextColumn _date;
  @override
  GeneratedTextColumn get date => _date ??= _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedTextColumn _time;
  @override
  GeneratedTextColumn get time => _time ??= _constructTime();
  GeneratedTextColumn _constructTime() {
    return GeneratedTextColumn(
      'time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, notes, date, time];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(NotesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.notes.present) {
      context.handle(
          _notesMeta, notes.isAcceptableValue(d.notes.value, _notesMeta));
    } else if (notes.isRequired && isInserting) {
      context.missing(_notesMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    if (d.time.present) {
      context.handle(
          _timeMeta, time.isAcceptableValue(d.time.value, _timeMeta));
    } else if (time.isRequired && isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Note.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.notes.present) {
      map['notes'] = Variable<String, StringType>(d.notes.value);
    }
    if (d.date.present) {
      map['date'] = Variable<String, StringType>(d.date.value);
    }
    if (d.time.present) {
      map['time'] = Variable<String, StringType>(d.time.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $PasswordsTable _passwords;
  $PasswordsTable get passwords => _passwords ??= $PasswordsTable(this);
  $CardDetailsTable _cardDetails;
  $CardDetailsTable get cardDetails => _cardDetails ??= $CardDetailsTable(this);
  $BanksTable _banks;
  $BanksTable get banks => _banks ??= $BanksTable(this);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  PasswordDao _passwordDao;
  PasswordDao get passwordDao =>
      _passwordDao ??= PasswordDao(this as AppDatabase);
  CardDetailDao _cardDetailDao;
  CardDetailDao get cardDetailDao =>
      _cardDetailDao ??= CardDetailDao(this as AppDatabase);
  BankDao _bankDao;
  BankDao get bankDao => _bankDao ??= BankDao(this as AppDatabase);
  NoteDao _noteDao;
  NoteDao get noteDao => _noteDao ??= NoteDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [passwords, cardDetails, banks, notes];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PasswordDaoMixin on DatabaseAccessor<AppDatabase> {
  $PasswordsTable get passwords => db.passwords;
}

mixin _$CardDetailDaoMixin on DatabaseAccessor<AppDatabase> {
  $CardDetailsTable get cardDetails => db.cardDetails;
}

mixin _$BankDaoMixin on DatabaseAccessor<AppDatabase> {
  $BanksTable get banks => db.banks;
}

mixin _$NoteDaoMixin on DatabaseAccessor<AppDatabase> {
  $NotesTable get notes => db.notes;
}
