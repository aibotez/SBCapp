import 'package:flutter/material.dart';
import 'package:app/factor_view/home_file_cell.dart';
import 'package:http/http.dart' as http;
import 'package:app/globals.dart';
import '../pack/userlogin.dart';
import 'dart:async';




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
  Map CurPageFiles = {};
  bool BarNotiOpen = false;
  StreamController<bool> _streamController_BarNotiOpen = StreamController();
  StreamController<bool> _streamController_BomNotiOpen = StreamController();
  StreamController<Map> streamController_FilesSelectAll = StreamController.broadcast();

  @override
  void dispose() {
    //销毁
    _streamController_BarNotiOpen.close();
    _streamController_BomNotiOpen.close();
    streamController_FilesSelectAll.close();
    super.dispose();
  }
  //Map FileInfos = {};

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


  Future get_cur_files() async{
    List <Widget> Files_Infos = [];
    Map PageFilesInfos = await UserLofin().FilesData(CurPath);
    List FilesInfos_all = PageFilesInfos['FileList'];
    Global.CurPage_File_Infos_Chosed={};
    for(var i=0;i<FilesInfos_all.length;i++){
      var FilesInfo=FilesInfos_all[i];
      FilesInfo['selectedValue'] = false;
      CurPageFiles[FilesInfo['filename']] = FilesInfo;
    }
    return HomeCell(key: UniqueKey(),PageFileInfos:CurPageFiles,CallbackFun:getChosed,streamController_FilesSelectAll:streamController_FilesSelectAll);
    //return Files_Infos;
  }
  void getChosed(){
    // List CurPageFileskeys = CurPageFiles.keys.toList();
    // for(var i=0;i<CurPageFileskeys.length;i++){
    //   CurPageFiles[CurPageFileskeys[i]]['selectedValue'] = true;
    // }
    // HomeCell.PageFileInfos1 = CurPageFiles;
    // HomeCell.a=1;
    //print(99);
    if (Global.CurPage_File_Infos_Chosed.length>0){
      _streamController_BarNotiOpen.add(true);
      _streamController_BomNotiOpen.add(true);
    }else{
      _streamController_BarNotiOpen.add(false);
      _streamController_BomNotiOpen.add(false);
    }

    //streamController_FilesSelectAll.add(CurPageFiles);

    print(Global.CurPage_File_Infos_Chosed.length);

    // setState(() {
    //
    // });



    //print(Global.CurPage_File_Infos_Chosed);
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

    void stlect_cancel_All(oper)
    {
      List CurPageFileskeys = CurPageFiles.keys.toList();
      if (oper=='s'){

        for(var i=0;i<CurPageFileskeys.length;i++){
          CurPageFiles[CurPageFileskeys[i]]['selectedValue'] = true;
          Global.CurPage_File_Infos_Chosed[CurPageFileskeys[i]] = CurPageFiles[CurPageFileskeys[i]];
        }
        streamController_FilesSelectAll.add(CurPageFiles);
      }
      else{
        for(var i=0;i<CurPageFileskeys.length;i++){
          CurPageFiles[CurPageFileskeys[i]]['selectedValue'] = false;
          Global.CurPage_File_Infos_Chosed.remove(CurPageFileskeys[i]);
        }
        streamController_FilesSelectAll.add(CurPageFiles);
        //getChosed();
      }
      getChosed();
    }


    void returnButon(){
      Global.CurPage_File_Infos_Chosed = {};
      Navigator.of(context).pop();

    }
    Widget titleWidget(){
      if (CurPath == '/home/'){
        Widget RowWidget = Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //color: Colors.red,
              width: 50,
              child: Text('分类'),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 100-40,
              child: Text('文件'),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 50,
              //color: Colors.red,
              child: Text('..'),
            )
          ],
        );
        return RowWidget;
      }
      var PathNameList = CurPath.split('/');
      String CurPathName = PathNameList[PathNameList.length-2];
      Widget RowWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            //color: Colors.red,
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap:(){returnButon();},
                ),
                Container(width: 10,),
                Expanded(child: Text(CurPathName)),
              ],
            ),
          ),
          Container(
            child: Text('sech'),
          )
        ],
      );
      return RowWidget;

    }
    return Scaffold(

      // floatingActionButton: Container(
      //   child: getWidget(),
      // ),

      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor:_themColr,
          centerTitle: true,
          automaticallyImplyLeading:false,
          elevation: 0.0,
          title: Stack(
            children: [
              titleWidget(),
              StreamBuilder<bool>(
          //初始值
                initialData: BarNotiOpen,
          //绑定Stream
                stream: _streamController_BarNotiOpen.stream,
                builder: (context,snapshot) {
                  return Container(
                    alignment: const FractionalOffset(0, 0),

                    child: Visibility (
                        visible: snapshot.data!, // 设置是否可见：true:可见 false:不可见
                        child: Container(


                          color: _themColr,
                          //height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child:Text('取消',style: TextStyle(color: Colors.blueAccent),),
                                onTap: (){stlect_cancel_All('');},
                              ),
                              Container(
                                child: Text('已选${Global.CurPage_File_Infos_Chosed.length}个/共${CurPageFiles.length}个'),
                              ),
                              GestureDetector(
                                child:Text('全选',style: TextStyle(color: Colors.blueAccent)),
                                onTap: (){stlect_cancel_All('s');},
                              ),
                            ],
                          ),
                        )
                    ),
                  );
                },
              ),



              // Container(
              //   alignment: const FractionalOffset(0, 0),
              //
              //   child: Visibility (
              //       visible: Global.FileChoseBarNotiOpen, // 设置是否可见：true:可见 false:不可见
              //       child: Container(
              //         color: Colors.red,
              //         width: MediaQuery.of(context).size.width,
              //         child: Text('test'),
              //       )
              //   ),
              // ),
            ],
          ),),



      body: PopScope(
        canPop: false,


        child: Container(
          color: _themColr,

          child: FutureBuilder(
            future: get_cur_files(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Text('');
              }else{
                //print(snapshot.data);
                return GestureDetector(
                  onTapUp: (e){
                    //getChosed();

                  },
                  child: snapshot.data,
                  //child: ListView(key: UniqueKey(),children: snapshot.data,),
                );
                //return ListView(children: snapshot.data,);
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

          String FaPath = GetFaPath();

          if(Global.CurPage_File_Infos_Chosed.length>0){
            stlect_cancel_All('');
            // print(Global.CurPage_File_Infos_Chosed.length);
            // List CurPageFileskeys = CurPageFiles.keys.toList();
            // for(var i=0;i<CurPageFileskeys.length;i++){
            //   CurPageFiles[CurPageFileskeys[i]]['selectedValue'] = false;
            // }
            // setState(() {
            //   _streamController_BarNotiOpen.add(false);
            //   _streamController_BomNotiOpen.add(false);
            // });
            return;
          }

          if (FaPath=='//'){
            return;
          }

          else{
            Global.CurPage_File_Infos_Chosed = {};
            Navigator.of(context).pop();
          }

        },
      ),


      //body: mywidget(),



      bottomNavigationBar:StreamBuilder<bool>(
        //初始值
        initialData: BarNotiOpen,
        //绑定Stream
        stream: _streamController_BomNotiOpen.stream,
        builder: (context,snapshot) {
          return Container(
            //alignment: const FractionalOffset(0, 0),

            child: Visibility (
                visible: snapshot.data!, // 设置是否可见：true:可见 false:不可见
                child: Container(
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width,
                  child: Text('test'),
                )
            ),
          );
        },
      ),


    );
  }
}
