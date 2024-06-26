import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'DownUpFileDbOper.dart';



class MyDatabase {
  String dbpath='';
  Database? db;

  Future<List> init(){
    database_path();
    Future<List> infoslist = initdb();
    // List infoslist = await getdata();
    // print(infoslist);
    closebase();

    MyDatabase_downup().init();

    return infoslist;


  }


  Future <void> database_path() async{
    dbpath = await getDatabasesPath();
    print('dbpath:');
    print(dbpath);
    final path = join(dbpath, 'netconfig.db');
    // await deleteDatabase(path);
    // final path = join(dbPath, 'my_database.db');
  }

  Future<void> init_user_info() async{


    final path = join(dbpath, 'user_info.db');
    Database db1 = await openDatabase(path);

    try{
      db1 = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db1, version) async {
          await db1.execute(
            'CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT,password TEXT)',
          );
        },
      );
    }catch(e){

    }
    db1.close();

  }



  Future<bool> add_user(name,password) async{
    List users = await get_user_data();
    if (users.length>0){
      del_user(users);
    }

    final path = join(dbpath, 'user_info.db');
    Database db1 = await openDatabase(path);

    await db1.insert(
      'user',
      {'username': name,'password':password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db1.close();
    return true;

  }


  Future<List> get_user_data() async{
    try{
      final path = join(dbpath, 'user_info.db');
      Database db1 = await openDatabase(path);
      List users = await db1.query('user');
      await db1.close();
      return users;
    }catch (e){
      return [];
    }
  }

  Future<bool> del_user(users) async{
    final path = join(dbpath, 'user_info.db');
    Database db1 = await openDatabase(path);
    for(var i=1;i<=users.length;i++){
      await db1.delete(
        'user',
        where: 'username = ?',
        whereArgs: [users[i]['username']],
      );
    }
    db1.close();
    return true;
  }



  Future<List> initdb() async{
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
        // insert();
        // print(66);
        List infoslist = await getdata();
        if(infoslist.length>1){
          print('>1');
          await deletdata(infoslist);
        }
        if(infoslist.length<1){
          print('<1');
          insert();
          infoslist = await getdata();
        }
        return infoslist;
        // print(a);

      } catch (e) {
      }
      return [];
  }


  Future<bool> deletdata(infoslist) async{
    final path = join(dbpath, 'netconfig.db');
    Database db1 = await openDatabase(path);
    List ids = [];
    for(var i=2;i<=infoslist.length;i++){
      ids.add(i);
      await db1.delete(
        'net',
        where: 'id = ?',
        whereArgs: [i],
      );
    }


    db1.close();


    return true;
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
    final path = join(dbpath, 'netconfig.db');
    Database db1 = await openDatabase(path);
    // final db = await MyDatabase().database;
    await db1.insert(
      'net',
      {'ipport': 'local.sbc.plus:90'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db1.close();
    return true;

  }

  Future<bool> closebase() async{
    await db?.close();
    return true;
  }

  Future <bool> updatedata(ipport) async{
    final path = join(dbpath, 'netconfig.db');
    Database db1 = await openDatabase(path);
    await db1.update(
      'net',
      {'ipport': ipport},
      where: 'id = ?',
      whereArgs: [1],
    );
    db1.close();
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
      return [];
    }

  }







}
