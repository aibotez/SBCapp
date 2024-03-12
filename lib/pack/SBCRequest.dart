import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals.dart';

class SBCRe{
  String host = Global.ipport;
  String Cookie="2290227486@qq.comauth:pbkdf2_sha256\$260000\$xAC7jRv2Ll6SyatWxYwKme\$+GOP625eAG4gvQAj4iZE9XUi5zBNYgl6NaNbvWSyWts=";


  FilesData(path) async{
    String urlstr = 'http://' + host + '/GetFileListbyClient/';
    final url = Uri.parse(urlstr);
    //pas
    // String Cookie="2290227486@qq.comauth:pbkdf2_sha256\$260000\$xAC7jRv2Ll6SyatWxYwKme\$+GOP625eAG4gvQAj4iZE9XUi5zBNYgl6NaNbvWSyWts=";
    //print(Cookie);
    Map data = {
      'path': path,
    };
    Map<String, String> headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Cookie':'coks='+Cookie
    };
    var response = await http.post(url,headers: headers,body:data);
    if (response.statusCode==200){
      Map PageFilesInfos = json.decode(response.body);
      // print(PageFilesInfos);
      // List CurFileList = FilesInfos['FileList'];
      return PageFilesInfos;
      // return CurFileList;
    }
    return [];
  }



   HostTest(host_test) async {
    String urlstr = 'http://' + host_test + '/ConnectTest/';
    final url = Uri.parse(urlstr);
    try{
      var response = await http.get(url).timeout(Duration(seconds: 2));
      if (response.statusCode==200){
        return true;
      }
    }catch(e){
      return false;
    }
    return false;

  }


  get_img_base64(path) async{
    String urlstr = 'http://' + host + '/preview/?filepath='+path;
    final url = Uri.parse(urlstr);
    Map data = {
      'filepath':path,
      'client':'windows'
    };

    Map<String, String> headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Cookie':'coks='+Cookie
    };
    var response = await http.get(url,headers: headers);

    // var response = await http.post(url,headers: headers,body:json.encode(data));
    print(path);
    if (response.statusCode==200){
      // Utf8Decoder utf8decoder = Utf8Decoder();
      // String ImgInfo = utf8decoder.convert(response.bodyBytes);
      // print(99);
      // print(response.body);
      // String ImgInfo = response.body;
      // print(ImgInfo);
      // print(PageFilesInfos);
      // List CurFileList = FilesInfos['FileList'];
      return response.bodyBytes;
      // return CurFileList;
    }
    print('get img fail');
    return '';



  }





}