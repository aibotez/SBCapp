import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class MyDatabase {
  String dbpath='';
  Database? db;

  MyDatabase(){
    database_path();
    initdb();
  }


  Future <void> database_path() async{
    dbpath = await getDatabasesPath();
    print('dbpath:');
    print(dbpath);
    // final path = join(dbPath, 'my_database.db');
  }

  void initdb() async{
    final path = join(dbpath, 'netconfig.db');
    try {
        db = await openDatabase(path);
        _initDatabase();
        insert();

      } catch (e) {
        _initDatabase();
        insert();
      }
    db = await openDatabase(path);
  }



  Future<Database> _initDatabase() async {
    final path = join(dbpath, 'netconfig.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE net(id INTEGER PRIMARY KEY AUTOINCREMENT, ipport TEXT)',
        );
      },
    );
  }

  Future<bool> insert() async{
    // final db = await MyDatabase().database;
    await db?.insert(
      'net',
      {'ipport': 'pi'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;

  }

  Future<List?> getdata() async{
    // final db = await MyDatabase().database;
    // List netconfig = await db?.query('netconfig');
    try{
      List? netconfig = await db?.query('net');
      return netconfig;
    }catch (e){
      return [6];
    }

  }







}
