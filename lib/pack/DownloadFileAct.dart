

class DownFIle{


  Map GetAllFilesfromFolder(folderinfo){

    Map Files = {};

    return Files;
  }

  void downact(fileinfo,local_dir){

  }

  void downdeal(fileinfo,local_dir){
    //write in database
    //upadte Golbal var
    //start down
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