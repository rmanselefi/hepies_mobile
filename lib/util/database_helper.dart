import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:hepies/models/favorites.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE favorites(id INTEGER PRIMARY KEY, name TEXT, route TEXT,strength TEXT,profession_id INTEGER,drug_name TEXT, unit TEXT )');
  }

  Future<int> saveFavorites(Favorites favorites) async {
    print("favorites.toMap() ${favorites.toMap()}");
    var dbClient = await db;
    int res = await dbClient.insert("favorites", favorites.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Favorites>> getFavoritesById(int id) async {
    List<Favorites> fav = [];
    var dbClient = await db;
    var ress = await dbClient.query("favorites",
        columns: ["id,name,route,strength,profession_id,drug_name,unit"],
        where: "profession_id = ?",
        whereArgs: [id]);
    if (ress.length == 0) return null;
    ress.forEach((element) {
      Favorites favorites = new Favorites(
          strength: element['strength'],
          route: element['route'],
          name: element['name'],
          drug_name: element['drug_name'],
          profession_id: element['profession_id'],
          unit: element['unit']);
      fav.add(favorites);
    });
    return fav;
  }

  Future<int> deleteFavorite(String name) async {
    var dbClient = await db;
    return await dbClient.delete("favorites", where: 'name = ?', whereArgs: [name]);
  }
}
