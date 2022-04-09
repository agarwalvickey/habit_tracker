import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "remind.db");
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Database get db {
    return _db;
  }

  // final int tripid;
  // final int serial_number;
  // final String type;
  // final String details;
  // final double amount_paid;
  // final String receipt_details;
  // final String receipt_address;
  // final String receipt_location;
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        'CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT,detail TEXT ,title TEXT,reminder_time TEXT, created_time TEXT)');
  }
}

class Injection {
  static final DatabaseHelper _databaseHelper = DatabaseHelper();
  static Injector injector;

  static Future initInjection() async {
    await _databaseHelper.initDb();

    injector = Injector();

    injector.map<DatabaseHelper>((i) => _databaseHelper, isSingleton: true);
  }
}