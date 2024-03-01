String getFileConPath(Map PageFileInfos){
  Map FileInfos = PageFileInfos['FileInfos'];
  String FileConPath = '';
  String fetype = FileInfos['fetype'];

  if (fetype == 'folder'){
    return 'src/img/filecon/folder1.png';
  }
  if (fetype == 'zip') {
    return 'src/img/filecon/zipcon.png';
  }

  if (fetype == 'img'){
    return 'src/img/filecon/imgcon.jpg';
  }

  if (fetype == 'pdf'){
    return 'src/img/filecon/pdfcon.jpg';
  }

  if (fetype == 'ppt'){
    return 'src/img/filecon/pptcon.jpg';
  }

  if (fetype == 'exe'){
    return 'src/img/filecon/execon.jpg';
  }

  if (fetype == 'excel'){
    return 'src/img/filecon/excelcon.jpg';
  }

  if (fetype == 'word'){
    return 'src/img/filecon/wordcon.jpg';
  }

  if (fetype == 'html'){
    return 'src/img/filecon/htmlcon.jpg';
  }
  else{
    return 'src/img/filecon/wj.jfif';
  }

  //
  // if (FileInfos['fetype'] =='folder'){
  //   FileConPath = 'src/img/filecon/foldersm.png';
  // }
  // if (FileInfos['fetype'] =='others'){
  //   FileConPath = 'src/img/filecon/wj.jfif';
  // }
  // FileConPath = 'src/img/filecon/foldersm.png';
  // return FileConPath;
}