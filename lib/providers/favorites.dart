import 'package:hepies/models/favorites.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  Future<void> saveFavorites(Favorites favorites) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),
// When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
// Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, name TEXT, route TEXT,strength TEXT)',
        );
      },
// Set the version. This executes the onCreate function and provides a
// path to perform database upgrades and downgrades.
      version: 1,
    );
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'favorites',
      favorites.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
