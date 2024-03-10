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
    // final path = join(dbpath, 'netconfig.db');
    // await deleteDatabase(path);
    // final path = join(dbPath, 'my_database.db');
  }

  void initdb() async{
    final path = join(dbpath, 'netconfig.db');
    try {
        db = await openDatabase(
          path,
          version: 1,
          onCreate: (Database db1, version) async {
            await db1.execute(
              'CREATE TABLE net(id INTEGER PRIMARY KEY AUTOINCREMENT, ipport TEXT)',
            );
          },
        );

        // _initDatabase();
        insert();
        print(66);
        List? a = await getdata();
        // print(a);

      } catch (e) {
      }
  }



  Future<Database> _initDatabase() async {
    final path = join(dbpath, 'netconfig.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db1, version) async {
        await db1.execute(
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

  Future<List> getdata() async{
    // final db = await MyDatabase().database;
    // List netconfig = await db?.query('netconfig');
    try{
      final path = join(dbpath, 'netconfig.db');
      Database db1 = await openDatabase(path);
      List netconfig = await db1.query('net');

      await db1.close();
      return netconfig;
    }catch (e){
      return [6];
    }

  }







}
