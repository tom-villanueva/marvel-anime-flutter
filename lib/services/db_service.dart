import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'favourites_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      db.execute('CREATE TABLE favourite_characters(id INTEGER PRIMARY KEY)');
      db.execute('CREATE TABLE favourite_series(id INTEGER PRIMARY KEY)');
    },
    version: 1,
  );
}
