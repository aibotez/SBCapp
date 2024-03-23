import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals.dart';

class UserLofin{
  String host = Global.ipport;

  FilesData(path) async{
    //String host = 'local.sbc.plus:9090';
    // String host = '10.147.17.34:9090';
    // String host = 'pi.sbc.plus:9090';

    String urlstr = 'http://' + host + '/GetFileListbyClient/';
    final url = Uri.parse(urlstr);
    //pas
    // String Cookie="2290227486@qq.comauth:pbkdf2_sha256\$600000\$dxsGpvBqPblQ1yzTFzbr9Q\$VfQcctfzyh2KsZQJSPcrnGPen0fRdzjO0EgeXtt6HKo=";
    //print(Cookie);
    Map data = {
      'path': path,
    };
    Map<String, String> headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Cookie':'coks='+Global.Cookie
    };

    var response = await http.post(url,headers: headers,body:data);
    // print(headers);
    if (response.statusCode==200){
      Map PageFilesInfos = json.decode(response.body);
      // print(PageFilesInfos);
      // List CurFileList = FilesInfos['FileList'];
      return PageFilesInfos;
      // return CurFileList;
    }

    //print(response.statusCode);
    //print(response.body);

    return [];
  }
}

