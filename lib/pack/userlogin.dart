import 'package:http/http.dart' as http;
import 'dart:convert';

class UserLofin{

  FilesData(path) async{
    String host = 'local.sbc.plus:9090';
    String urlstr = 'http://' + host + '/GetFileListbyClient/';
    final url = Uri.parse(urlstr);
    String Cookie="2290227486@qq.comauth:pbkdf2_sha256\$260000\$xAC7jRv2Ll6SyatWxYwKme\$+GOP625eAG4gvQAj4iZE9XUi5zBNYgl6NaNbvWSyWts=";
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

    //print(response.statusCode);
    //print(response.body);

    return [];
  }
}

// def GetFileList(self,path):
// url = 'http://' + self.host + '/GetFileListbyClient/'
// data = {
// 'path': path,
// }
// # print(self.headers)
// res = requests.post(url, data=data,headers=self.headers)
// # print(res)
// FileDatas = json.loads(res.text)
// # print(self.headers,FileDatas)
// # print(FileDatas['FileList'])
// # for i in FileDatas['FileList']:
// #     print(i)
// self.CurFileList = FileDatas['FileList']
// self.Nav = FileDatas['Nav']
// self.imgFiles = FileDatas['imgFiles']
// return FileDatas['FileList']