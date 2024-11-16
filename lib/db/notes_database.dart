import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgrade, // Handle schema upgrades
    );
  }

  // Create the notes table with the new 'color' column
  Future<void> _createDB(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        date TEXT NOT NULL,
        color INTEGER
      )
    ''');
  }

  // Handle schema upgrade when the database version changes
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add the 'color' column to existing notes table (if upgrading from version < 2)
      await db.execute('''
        ALTER TABLE notes ADD COLUMN color INTEGER NOT NULL DEFAULT 0
      ''');
    }
  }

  // Create a new note
  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert('notes', note.toMap());
    return note.copyWith(id: id);
  }

  // Read a note by its ID
  Future<Note?> readNoteById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Read all notes
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = 'date DESC';
    final result = await db.query('notes', orderBy: orderBy);

    return result.map((map) => Note.fromMap(map)).toList();
  }

  // Update an existing note
  Future<int> update(Note note) async {
    final db = await instance.database;
    return db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Delete a note by its ID
  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close the database connection
  Future<void> close() async {
    final db = await _database;
    if (db != null) {
      await db.close();
    }
  }
}
