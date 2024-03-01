import 'package:flutter/material.dart';
import 'package:app/factor_view/home_file_cell.dart';
import 'package:http/http.dart' as http;
import 'package:app/globals.dart';
import '../pack/userlogin.dart';



class File_Page extends StatefulWidget {
  //const File_Page({super.key});

  File_Page(this.CurPath);
  String CurPath;


  @override
  State<File_Page> createState() => _File_PageState(CurPath);
}

class _File_PageState extends State<File_Page> {
  _File_PageState(this.CurPath);
  String CurPath;
  
  // @override
  // void initState(){
  //   super.initState();
  //   getDatas().then((value){
  //     print(value);
  //     setState(() {});
  //   });
  // }
  //Color _themColr = Color.fromRGBO(220, 220, 220, 1.0);

  Color _themColr = Color.fromRGBO(253, 254, 254 , 1.0);
  var FileInfos = {'Filetype':'folder','FileName':'abc.txt','FileDate':'2023-06-12 07:60','FileSize':'8.29MB','FileChosed':false};
  var FileInfos1 = {'Filetype':'others','FileName':'fsiuf的44557.ISO','FileDate':'2023-06-12 07:60','FileSize':'8.29MB','FileChosed':false};
  List <Widget> FileList = [];

  Future get_cur_files() async{
    List <Widget> Files_Infos = [];
    Map PageFilesInfos = await UserLofin().FilesData(CurPath);
    List FilesInfos_all = PageFilesInfos['FileList'];

    Global.CurPage_File_Infos = {};
    Global.CurPage_File_Infos_Chosed={};
    Global.FileSelectState = 0;


    for(var i=0;i<FilesInfos_all.length;i++){
      Files_Infos.add(HomeCell({'FileInfos':FilesInfos_all[i],'NavInfos':PageFilesInfos['Nav']}));
      Global.CurPage_File_Infos[FilesInfos_all[i]['filename']]=FilesInfos_all[i];
      Global.CurPage_File_Infos[FilesInfos_all[i]['filename']]['selectedValue'] = false;
    }
    return Files_Infos;
  }
  void getChosed(){
    print(Global.CurPage_File_Infos_Chosed);
  }
  // Future getDatas() async {
  //   String urlstr = 'http://rap2api.taobao.org/app/mock/311243/api/chat/list';
  //   final url = Uri.parse(urlstr);
  //   var response = await http.get(url,);
  //   //print(response.statusCode);//200
  //   //print(response.body);//这里就是我们自定义的网络数据了
  //   //return response;
  //   //FileList.add(HomeCell({'Filetype':'others','FileName':'test','FileDate':'2023-06-12 07:60','FileSize':'8.29MB','FileChosed':false}));
  //   return [HomeCell({'Filetype':'others','FileName':'test','FileDate':'2023-06-12 07:60','FileSize':'8.29MB','FileChosed':false})];
  // }
  @override
  Widget build(BuildContext context) {
    //getDatas();
    //UserLofin().FilesData('/home/');
    String GetFaPath(){
      List pathlist = CurPath.split('/');
      String FaPath = '/';
      for(var i=1;i<pathlist.length-2;i++){
        //print(pathlist[i]);
        FaPath = FaPath +pathlist[i];
      }
      FaPath = FaPath + '/';
      //print(FaPath);

      return FaPath;
    }

    Widget getWidget() {
      return const Visibility (
          visible: true, // 设置是否可见：true:可见 false:不可见
          child: Text('Hello World')
      );
    }

    return Scaffold(

      // floatingActionButton: Container(
      //   child: getWidget(),
      // ),

      appBar: AppBar(
          backgroundColor:_themColr,
          centerTitle: true,


          elevation: 0.0,



          //backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('文件',style: TextStyle(color:Colors.black))),
      body: PopScope(
        canPop: false,

        child: Container(
          color: _themColr,

          child: FutureBuilder(
            future: get_cur_files(),
            // future: getDatas(),
            //future: UserLofin().FilesData('/home/'),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Text('');
              }else{
                //print(snapshot.data);
                // return GestureDetector(
                //   onTap: (){
                //
                //   },
                //   child: ListView(children: snapshot.data,),
                // );
                return ListView(children: snapshot.data,);
              }
            },
          ),
          // child: ListView(
          //   children: [HomeCell(FileInfos),HomeCell(FileInfos1)],
          // ),
        ),
        onPopInvoked : (didPop) {//onWillPop

          if (didPop) {
            return;
          }
          //print('11');
          //print(CurPath);
          String FaPath = GetFaPath();
          //getChosed();
          //Navigator.of(context).pop();
          //Navigator.pop(context);
          //return;


          if (FaPath=='//'){
            //return;
          }
          if(Global.CurPage_File_Infos_Chosed.length>0){
            print(Global.CurPage_File_Infos_Chosed.length);
            return;
          }
          else{
            Navigator.of(context).pop();
          }
          // else{
          //   Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => File_Page(FaPath)));
          //   //return true;
          // }
          //Global.CurPage_File_Infos = {};

        },
      ),

      //body: mywidget(),
    );
  }
}
