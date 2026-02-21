import 'package:sqflite/sqflite.dart';
import 'package:restaurants_app/data/model/restaurants.dart';

class LocalDatabaseService {
  static const String _databaseName = 'restaurants-app.db';
  static const String _tableName = 'restaurants';
  static const int _version = 2;

  Future<void> createTables(Database database) async{
    await database.execute(
      """CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
      )
      """,
    );
  }

  Future<Database> _initializeDb() async{
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async{
        await createTables(database);
      },
    );
  }

  Future<void> insertItem(Restaurants restaurants) async{
    final db = await _initializeDb();

    final data = restaurants.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } 

  Future<List<Restaurants>> getAllItems() async{
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) => Restaurants.fromJson(result)).toList();
  }

  Future<Restaurants?> getItemById(String id) async{
    final db = await _initializeDb();
    final results = 
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.isEmpty ? null : Restaurants.fromJson(results.first);
  }

  Future<int> removeItem(String id) async{
    final db = await _initializeDb();

    final result = 
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}