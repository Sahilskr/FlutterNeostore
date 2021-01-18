// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Add extends DataClass implements Insertable<Add> {
  final int id;
  final String address;
  final String email;
  Add({@required this.id, @required this.address, @required this.email});
  factory Add.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Add(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      address:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}address']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    return map;
  }

  AddsCompanion toCompanion(bool nullToAbsent) {
    return AddsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory Add.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Add(
      id: serializer.fromJson<int>(json['id']),
      address: serializer.fromJson<String>(json['address']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'address': serializer.toJson<String>(address),
      'email': serializer.toJson<String>(email),
    };
  }

  Add copyWith({int id, String address, String email}) => Add(
        id: id ?? this.id,
        address: address ?? this.address,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('Add(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(address.hashCode, email.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Add &&
          other.id == this.id &&
          other.address == this.address &&
          other.email == this.email);
}

class AddsCompanion extends UpdateCompanion<Add> {
  final Value<int> id;
  final Value<String> address;
  final Value<String> email;
  const AddsCompanion({
    this.id = const Value.absent(),
    this.address = const Value.absent(),
    this.email = const Value.absent(),
  });
  AddsCompanion.insert({
    this.id = const Value.absent(),
    @required String address,
    @required String email,
  })  : address = Value(address),
        email = Value(email);
  static Insertable<Add> custom({
    Expression<int> id,
    Expression<String> address,
    Expression<String> email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (address != null) 'address': address,
      if (email != null) 'email': email,
    });
  }

  AddsCompanion copyWith(
      {Value<int> id, Value<String> address, Value<String> email}) {
    return AddsCompanion(
      id: id ?? this.id,
      address: address ?? this.address,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddsCompanion(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $AddsTable extends Adds with TableInfo<$AddsTable, Add> {
  final GeneratedDatabase _db;
  final String _alias;
  $AddsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _addressMeta = const VerificationMeta('address');
  GeneratedTextColumn _address;
  @override
  GeneratedTextColumn get address => _address ??= _constructAddress();
  GeneratedTextColumn _constructAddress() {
    return GeneratedTextColumn(
      'address',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, address, email];
  @override
  $AddsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'adds';
  @override
  final String actualTableName = 'adds';
  @override
  VerificationContext validateIntegrity(Insertable<Add> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address'], _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Add map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Add.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AddsTable createAlias(String alias) {
    return $AddsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AddsTable _adds;
  $AddsTable get adds => _adds ??= $AddsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [adds];
}
