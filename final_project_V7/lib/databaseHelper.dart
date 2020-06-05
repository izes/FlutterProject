import 'dart:io';
import './models/user.dart';
import './models/author.dart';
import './models/quote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  static final _databaseName = 'dbDemo.db';
  static final _databaseVersion = 1;

  //Table Users
  static final userTable = 'user_table';
  static final colId = 'id';
  static final colUserName = 'userName';

  //Table Authors
  static final authorTable = 'author_table';
  static final colAuthorId = 'authorId';
  static final colAuthorName = 'authorName';
  static final colAuthorBirth = 'authorBirth';
  static final colAuthorNationality = 'authorNationality';
  static final colAuthorOccupation = 'authorOccupation';
  static final colAuthorFact = 'authorFact';

  //Table Quote
  static final quoteTable = 'quote_table';
  static final colQuoteId = 'quoteId';
  static final colQuoteName = 'quoteName';
  static final colQuoteLike = 'quoteLike';

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
        CREATE TABLE $userTable(
          $colId INTEGER PRIMARY KEY, 
          $colUserName TEXT NOT NULL
        )
        ''');

    await db.execute('''
        CREATE TABLE $authorTable(
          $colAuthorId INTEGER PRIMARY KEY, 
          $colAuthorName TEXT NOT NULL,
          $colAuthorBirth TEXT NOT NULL,
          $colAuthorNationality TEXT NOT NULL,
          $colAuthorOccupation TEXT NOT NULL,
          $colAuthorFact TEXT NOT NULL
        )
        ''');

    await db.execute('''
        CREATE TABLE $quoteTable(
          $colQuoteId INTEGER PRIMARY KEY,
          $colQuoteName TEXT NOT NULL,
          $colQuoteLike INT NOT NULL,
          $colAuthorId INT NOT NULL,
          FOREIGN KEY($colAuthorId) REFERENCES $authorTable($colAuthorId)
        )
         ''');

    await db.rawInsert('''INSERT INTO $authorTable(
             $colAuthorId,
             $colAuthorName, 
             $colAuthorBirth, 
             $colAuthorNationality, 
             $colAuthorOccupation, 
             $colAuthorFact) VALUES
             (1,"Bukowski","August 16, 1920","German-American","Poet Novelist",
               "He hated being around people. 
                      Once he said 'Even though I write about the 
                      human race, the further away from them the 
                      better I feel. Two miles is great, two thousand
                      miles is beautiful. I do not like the human race. 
                      I don’t like their heads, I don’t like their faces,
                      I don’t like their feet, I don’t like their 
                      conversations, I don’t like their hairdos, I don’t
                      like their automobiles.'"),
              (2,"Shakespeare","April 26, 1564", "English", "Poet actor",
              "Nobody knows what Shakespeare 
                        did between 1585 and 1592.To the dismay 
                        of his biographers, Shakespeare 
                        disappears from the historical record 
                        between 1585, when his twins’ baptism 
                        was recorded, and 1592, when the 
                        playwright Robert Greene denounced him 
                        in a pamphlet as an “upstart crow.
                         
                         "),
                (3, "Descartes", "March 31, 1596", "French", "Philosopher and scientist",
                "Descartes was born in minor 
                        French nobility. His mother died soon 
                        after giving birth to him, his father 
                        remarried and he was raised by his 
                        maternal grandmother. His religious 
                        views are still debated, as he claimed 
                        to have been a Catholic but was accused 
                        of actually having atheist beliefs.")                      
           ''');

    await db.rawInsert('''INSERT INTO $quoteTable(
             $colQuoteId,
             $colQuoteName, 
             $colQuoteLike, 
             $colAuthorId) VALUES
             (1,
             "Some people never go crazy. What truly 
             horrible lives they must lead.",4,1),
            (2,"Find what you love and let it kill you.",5,1),
            (3,"I guess the only time most people think about
            injustice is when it happens to them.",3,1),
            (4,"There is nothing either good or bad, but 
            thinking makes it so.",1,2),
            (5,"Some rise by sin, and some by virtue 
            fall.",1,2),       
            (6,"Men at some time are masters of their fates:
            The fault, dear Brutus, is not in our stars, 
            but in ourselves, that we are underlings.",0,2),
            (7,"Except our own thoughts, there is nothing 
            absolutely in our power.",2,3),
            (8,"The senses deceive from time to time, and it 
            is prudent never to trust wholly those who have 
            deceived us even once.",2,3),
            (9,"If you would be a real seeker after truth, 
            it is necessary that at least once in your life 
            you doubt, as far as possible, all things.",1,3)
           ''');
  }

  //Only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //Helper Methods

  //Insert a row in the database where each key in the map is a column name
  // and the value is the column value. The return value is the id of the inserted row
  Future<int> insert(User user) async {
    Database db = await instance.database;
    return await db
        .insert(userTable, {'id': user.id, 'userName': user.userName});
  }

  // All od the rows are returned as a list of maps, where each map is a keu-value list of columns
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(userTable);
  }

  //Query by Name
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(userTable, where: "$colUserName LIKE '$name'");
  }

  //Insert Authors
  Future<int> insertAuthor(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(authorTable, row);
  }

  //Author by name
  Future<List<Map<String, dynamic>>> queryAuthor(author) async {
    Database db = await instance.database;
    return await db.query(authorTable, where: "$colAuthorName LIKE '$author'");
  }

  //Quote by Author Id
  Future<List<Map<String, dynamic>>> queryQuote(authorid) async {
    Database db = await instance.database;
    return await db.query(quoteTable, where: "$colAuthorId LIKE '$authorid'");
  }

  //Quote Likes update
  Future<int> updateLike(Quote quote) async {
    Database db = await instance.database;
    int id = quote.toMap()['quoteId'];
    return await db.update(quoteTable, quote.toMap(),
        where: '$colQuoteId = ?', whereArgs: [id]);
  }
}
