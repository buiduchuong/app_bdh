import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE TOKEN ( token TEXT )');
  }

  Future<int> create(String note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db.rawInsert('INSERT INTO TOKEN(token) VALUES ($note)');
    int id1 = await db.rawInsert('INSERT INTO TOKEN(token) VALUES("$note")');
    return id1;
  }

  Future<List<Map>> readAllNotes() async {
    final db = await instance.database;

    // List<Map> result = await db.rawQuery('SELECT * FROM TOKEN');

    final result = await db.query('TOKEN');
    return result;
  }

  Future<int> delete() async {
    final db = await instance.database;

    return await db.delete(
      'TOKEN',
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
