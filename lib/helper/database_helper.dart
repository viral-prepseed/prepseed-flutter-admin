// needed for Directory()
import 'dart:io';
// needed for join()
import 'package:path/path.dart';
// needed for SQL database operations
import 'package:sqflite/sqflite.dart';
// needed for getApplicationDocumentsDirectory()
import 'package:path_provider/path_provider.dart';

// database table and column names
// final String tableWords = 'words';
final String tableWords = 'flowSync';
final String columnId = '_id';
final String columnWord = 'word';
final String columnFrequency = 'frequency';


class FlowSync{
  int? section;
  int? question;
  dynamic response;
  dynamic time;
  int? state;

  FlowSync.fromMap(Map<dynamic, dynamic> map) {
    section = map['section'];
    question = map['question'];
    response = map['response'];
    time = map['time'];
    state = map['state'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "section": section,
      "question": question,
      "response": response,
      "time": time,
      "state": state,
    };
    return map;
  }
}


// data model class
class Word {

   int? id;
   String? word;
   int? frequency;

  // Word(this.id, this.word, this.frequency);


  // convenience constructor to create a Word object
  fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    frequency = map[columnFrequency];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnWord: word,
      columnFrequency: frequency
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "prepseed.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database, can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableWords (
            'question' INTEGER NOT NULL,
            'section' INTEGER NOT NULL,
            'response' TEXT NOT NULL,
            'time' TEXT NOT NULL,
            'state' INTEGER NOT NULL
          )
          ''');
  }

  // Database helper methods:

  Future<int> insert(FlowSync word) async {
    Database db = await database;
    int id = await db.insert(tableWords, word.toMap());
    return id;
  }

  Future<dynamic> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: ['question', 'section', 'response','time','state'],
        where: 'question = ?',
        whereArgs: [id]);
    // print(maps);
    if (maps.length > 0) {
      return maps.first;
    }
    // return null;
  }

  Future<List<Word>?> queryAllWords() async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords);
    if (maps.length > 0) {
      List<Word> words = [];
      maps.forEach((map) => words.add(Word().fromMap(map)));
      return words;
    }
    return null;
  }

  Future<int> deleteWord(int id) async {
    Database db = await database;
    return await db.delete(tableWords, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Word word) async {
    Database db = await database;
    return await db.update(tableWords, word.toMap(),
        where: '$columnId = ?', whereArgs: [word.id]);
  }

}
