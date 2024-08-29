import 'dart:async';
import 'dart:typed_data';
import 'package:photo_app/src/domain/models/image_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'agenda.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE image(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dateTime TEXT,
        latitude TEXT,
        longitude TEXT,
        imagePath BLOB
      )
    ''');
  }

  Future<int> insertImage(ImageModel data) async {
    Uint8List? image = Uint8List.fromList(data.imagePath ?? []);
    Database db = await database;
    return await db.insert('image', {
      'dateTime': data.dateTime,
      'latitude': data.latitude,
      'longitude': data.longitude,
      'imagePath': image
    });
  }

  Future<List<Map<String, dynamic>>> getImages() async {
    Database db = await database;
    return await db.query('image');
  }

  Future<List<ImageModel>> getListImage() async {
    var result = await getImages();
    return result.map((e) => ImageModel.fromJSON(e)).toList();
  }

  Future<void> dropTable() async {
    if (_database != null) {
      await _database!.execute('DELETE FROM agenda');
    }
  }
}
