import 'package:moor_flutter/moor_flutter.dart';
part 'db.g.dart';


class Adds extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get address => text()();

  TextColumn get email => text()();

}

@UseMoor(tables: [Adds])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  static AppDatabase database;

  static AppDatabase getDatabase() {
    if (database == null) {
      database = AppDatabase();
    }
    return database;
  }
  Future insertAdd(Add add) => into(adds).insert(add);
  Stream<List<Add>> watchAdds() => select(adds).watch();

  Future<List<Add>> getAdds(String email) {
    return (select(adds)..where((t) => t.email.equals(email))).get();
  }
}

