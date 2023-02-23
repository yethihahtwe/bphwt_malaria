import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _db;
  static const String malariaTable = 'malaria';

  static var instance;
  DatabaseHelper() {
    _createDatabase();
  }
/*CREATE TABLES*/
  Future<Database> _createDatabase() async {
    var dataPath = await getDatabasesPath();
    String path = join(dataPath, "malaria.db");
    _db = await openDatabase(path);

//CREATE MALARIA TABLE
    await _db.execute(
        'CREATE TABLE IF NOT EXISTS $malariaTable(id INTEGER PRIMARY KEY, rx_month TEXT, rx_year TEXT, test_date TEXT, name TEXT, age TEXT, address TEXT, sex TEXT, pregnancy TEXT, rdt_bool TEXT, rdt_pos_result TEXT, symptom TEXT, act24 TEXT, act24_amount TEXT, act18 TEXT, act18_amount TEXT, act12 TEXT, act12_amount TEXT, act6 TEXT, act6_amount TEXT, chloroquine TEXT, chloroquine_amount TEXT, primaquine TEXT, primaquine_amount TEXT, refer TEXT, death TEXT, receive_rx TEXT, travel TEXT, job TEXT, other_job TEXT, remark TEXT, state TEXT, tsp_mimu TEXT, tsp_eho TEXT, area TEXT, region TEXT, vil TEXT, usr_name TEXT, usr_id TEXT)');
    return _db;
  }

// INSERT INTO MALARIA TABLE
  Future<int> insertMalaria(Map<String, dynamic> malaria) async {
    _db = await _createDatabase();
    return await _db.insert(malariaTable, malaria);
  }

//SELECT * FROM MALARIA TABLE
  Future<List<Map<String, dynamic>>> getAllMalaria() async {
    _db = await _createDatabase();
    // return await _db.query(malariaTable, columns: []);
    return await _db.rawQuery('SELECT * from $malariaTable ORDER BY id desc');
  }

//UPDATE MALARIA TABLE
  Future<int> updateMalaria(Map<String, dynamic> malaria, int id) async {
    _db = await _createDatabase();
    return await _db
        .update(malariaTable, malaria, where: "id=?", whereArgs: [id]);
  }

//DELETE MALARIA ROW
  Future<int> deleteMalaria(int id) async {
    _db = await _createDatabase();
    return await _db.delete(malariaTable, where: "id=?", whereArgs: [id]);
  }

//DELETE ALL ROW MALARIA TABLE
  Future<int> delete() async {
    _db = await _createDatabase();
    return await _db.rawDelete("DELETE FROM $malariaTable");
  }
}
