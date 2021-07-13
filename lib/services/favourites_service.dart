import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/services/db_service.dart';
import 'package:sqflite/sqflite.dart';

final String db_fav_char = 'favourite_characters';

class FavouritesService {
  Future<bool> insertCharacter(Character character) async {
    // Get a reference to the database.
    final db = await getDatabase();

    int result = await db.insert(
      db_fav_char,
      {'id': character.id},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<void> deleteCharacter(Character character) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Remove the Dog from the database.
    await db.delete(
      db_fav_char,
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [character.id],
    );
  }

  Future<List<int>> getFavouriteCharacters() async {
    // Get a reference to the database.
    final db = await getDatabase();

    return await db.query(db_fav_char, columns: ['id']).then(
        (results) => results.map((e) => e["id"] as int).toList());
  }
}
