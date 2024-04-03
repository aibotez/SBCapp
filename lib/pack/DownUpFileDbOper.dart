import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase_downup {
  String dbpath = '';
  Database? db;
  String Dbpath = '';

  Future<void> init() async {
    getdbpath();
    init_file_info();
    // database_path();
    // Future<List> infoslist = initdb();
    // // List infoslist = await getdata();
    // // print(infoslist);
    // closebase();
    // return infoslist;
  }

  Future<void> getdbpath() async {
    dbpath = await getDatabasesPath();
    Dbpath = join(dbpath, 'DownUpFile_info.db');
  }


  Future<void> init_file_info() async{

    // dbpath = await getDatabasesPath();


    // final path = join(dbpath, 'DownUpFile_info.db');
    // Dbpath = join(dbpath, 'DownUpFile_info.db');
    Database? db;


    try{
      db = await openDatabase(
        Dbpath,
        version: 1,
        onCreate: (Database db1, version) async {
          await db1.execute(
            'CREATE TABLE DownFile(id INTEGER PRIMARY KEY AUTOINCREMENT, md5 TEXT,filename TEXT,downpath TEXT,savepath TEXT)',
          );
          await db1.execute(
            'CREATE TABLE UpFile(id INTEGER PRIMARY KEY AUTOINCREMENT, md5 TEXT,filename TEXT,uppath TEXT,savepath TEXT)',
          );
        },
      );
    }catch(e){

      print('OpenDownUpDb Error!!');

    }
    db?.close();

  }

  Future<Database> openDb() async{
    dbpath = await getDatabasesPath();
    Dbpath = join(dbpath, 'DownUpFile_info.db');
    Database db = await openDatabase(Dbpath);
    return db;
  }


  Future<bool> add_down(fileinfo,db) async{
    if (fileinfo.length<=0){
      return false;
    }

    // Database db1 = await openDatabase(Dbpath);
    await db.insert(
      'DownFile',
      {'md5': fileinfo['md5'],'filename':fileinfo['filename'],'downpath':fileinfo['downpath'],'savepath':fileinfo['savepath']},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // db1.close();
    return true;

  }

  Future<bool> add_up(fileinfo,db) async{
    if (fileinfo.length<=0){
      return false;
    }

    // Database db1 = await openDatabase(Dbpath);
    await db.insert(
      'UpFile',
      {'md5': fileinfo['md5'],'filename':fileinfo['filename'],'uppath':fileinfo['uppath'],'savepath':fileinfo['savepath']},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // db1.close();
    return true;

  }


  Future<bool> del_down(db,fileinfo) async{
    await db.delete(
      'DownFile',
      where: 'savepath = ?',
      whereArgs: fileinfo['savepath'],
    );
    return true;

  }

  Future<bool> del_up(db,fileinfo) async{
    await db.delete(
      'UpFile',
      where: 'savepath = ?',
      whereArgs: fileinfo['savepath'],
    );
    return true;

  }


  Future<bool> closebase(db) async{
    await db.close();
    return true;
  }







}