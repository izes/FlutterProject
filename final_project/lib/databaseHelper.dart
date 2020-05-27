import 'dart:io';
import './models/user.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper{
  static final _databaseName = 'dbDemo.db';
  static final _databaseVersion = 1;

  static final table = 'user_table';

  static final colId = 'id';
  static final colUserName = 'userName';

  //Make this a singleton class
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  //this opens the database and created it if it doesnt exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print(path);

    return await openDatabase(path,
      version: _databaseVersion, onCreate: _onCreate);
  }

  //SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table(
          $colId INTEGER PRIMARY KEY, 
          $colUserName TEXT NOT NULL
        )
        ''');
  }
  //Only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //Helper Methods

  //Insert a row in the database where each key in the map is a column name
  // and the value is the column value. The return value is the id of the inserted row
  Future<int> insert(User user) async{
    Database db = await instance.database;
    return await db.insert(table, 
      { 'id': user.id, 'userName': user.userName });
  }

  // All od the rows are returned as a list of maps, where each map is a keu-value list of columns 
  // Future<List<Map<String, dynamic>>> queryAllRows() async {
  //   Database db = await instance.database;
  //   return await db.query(table);
  // }

  Future<List<Map<String, dynamic>>> queryRows(name) async {
     Database db = await instance.database;
     return await db.query(table, where: "$colUserName LIKE '%$name%'");
   }

  //   Future<int> update(User user) async {
  //   Database db = await instance.database;
  //   int userId = user.toMap()['userId'];
  //   return await db.
  //     update(table, user.toMap(), where: '$colUserId = ?', whereArgs: [userId]);
  // }

  // //Delete row based on id
  // Future<int> delete(int userId) async {
  //   Database db = await instance.database;
  //   return await db.delete(table, where: '$colUserId = ?', whereArgs: [userId]);
  // }
}