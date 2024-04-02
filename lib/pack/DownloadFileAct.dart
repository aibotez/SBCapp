import 'package:sqflite/sqflite.dart';

import 'DownUpFileDbOper.dart';

class DownFIle{

  var Database_downup = MyDatabase_downup();


  Map GetAllFilesfromFolder(folderinfo){

    Map Files = {};

    return Files;
  }

  void downact(fileinfo,local_dir){

  }

  Future<void> downdeal(fileinfo,local_dir) async {
    //write in database
    //upadte Golbal var
    //start down

    Database db = await Database_downup.openDb();
    fileinfo['savepath'] = local_dir+'/'+fileinfo['filename'];
    Database_downup.add_down(fileinfo,db);


  }

  void downfile(downfileinfo){
    if (downfileinfo['isdir']){
      Map Files = GetAllFilesfromFolder(downfileinfo);
      for (var i=0;i<Files.length;i++){

      }
    }else{

    }
  }

}