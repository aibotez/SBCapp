import 'dart:convert';

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


    // Database_downup.getdbpath();
    Database db = await Database_downup.openDb();
    //
    fileinfo['savepath'] = local_dir+'/'+fileinfo['filename'];
    List<int> bytes = base64Decode(fileinfo['filelj']);
    String remotepath = String.fromCharCodes(bytes);
    print(remotepath);
    fileinfo['savepath'] = local_dir;
    fileinfo['downpath'] = remotepath;
    Database_downup.add_down(fileinfo,db);
    db.close();


  }

  void downfile(downfileinfos){

    print(downfileinfos);
    for (var i=0;i<downfileinfos.length;i++){
      Map downfileinfo = downfileinfos[i];
      if (downfileinfo['isdir']!=0){
        Map Files = GetAllFilesfromFolder(downfileinfo);
        for (var i=0;i<Files.length;i++){

        }
      }else{
        downdeal(downfileinfo,'local_dir');
      }

    }



  }

}