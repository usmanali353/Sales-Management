import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Products.dart';

class sqlite_helper{
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }
  initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'sales.db');
    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Products ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "ItemNumber TEXT,"
        "ItemName  TEXT,"
        "SizeItem TEXT,"
        "InventoryDimension TEXT,"
        "ColorItem TEXT,"
        "PickingId TEXT,"
        "Grade TEXT,"
        "SalesQuantity DOUBLE"
        ")");

  }
  //Health Record
  Future<int> addProducts(Products products) async {
    var dbClient = await db;
    var result = await dbClient.insert("Products", products.toMap());
    return result;
  }
  Future<List> getProducts() async {
    var dbClient= await db;
    var result = await dbClient.rawQuery('SELECT * FROM Products');
    return result.toList();
  }
  Future<List> checkAlreadyExists(String ItemNumber) async {
    var dbClient= await db;
    var result = await dbClient.query("Products",where: 'ItemNumber = ?',whereArgs: [ItemNumber]);
    return result.toList();
  }
  Future<int> deleteProducts() async {
    var dbClient= await db;
    return await dbClient.rawDelete('DELETE FROM Products');
  }
//  //Training
// Future<int> create_training(Training training) async {
//  var dbClient = await db;
//   var result = await dbClient.insert("Training", training.toMap());
//   return result;
// }
//  Future<List> getTraining() async {
//    var dbClient= await db;
//    var result = await dbClient.rawQuery('SELECT * FROM Training');
//    return result.toList();
//  }
//  Future<int> deleteTraining() async {
//    var dbClient= await db;
//    return await dbClient.rawDelete('DELETE FROM Training');
//  }
//  //Add Note
//
//  Future<int> create_add_note(Add_Note add_note) async {
//    var dbClient = await db;
//    var result = await dbClient.insert("Add_Note", add_note.toMap());
//    return result;
//  }
//  Future<List> get_add_note() async {
//    var dbClient= await db;
//    var result = await dbClient.rawQuery('SELECT * FROM Add_Note');
//    return result.toList();
//  }
//  Future<int> delete_add_note() async {
//    var dbClient= await db;
//    return await dbClient.rawDelete('DELETE FROM Add_Note');
//  }

}
