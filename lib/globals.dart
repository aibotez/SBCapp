
import 'package:sqflite/sqflite.dart';
import 'pack/dboper.dart';

class Global{
  // var dbclass = MyDatabase();

  static Map CurPage_File_Infos = {};
  static Map CurPage_File_Infos_Chosed = {};
  static int FileSelectState=0;
  static String ipport='';
  // static bool FileChoseBarNotiOpen = false;
  static var db;
}