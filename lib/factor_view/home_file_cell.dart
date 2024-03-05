import 'package:flutter/material.dart';
import '../pages/file_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pack/getfileconpath.dart';
import 'package:app/globals.dart';
import 'dart:async';

// import 'package:app/globals.dart' as globals;



class HomeCell extends StatefulWidget {
  Map PageFileInfos;
  StreamController<Map> streamController_FilesSelectAll;
  final VoidCallback CallbackFun;
  HomeCell({required Key key, required this.PageFileInfos,required this.CallbackFun,required this.streamController_FilesSelectAll}) : super(key: key);
  //HomeCell(this.PageFileInfos,this.FileName,this.CallbackFun);
  //const HomeCell({super.key});
  @override
  State<HomeCell> createState() => HomeCellState(PageFileInfos,CallbackFun,streamController_FilesSelectAll);

}



//class HomeCell1 extends StatelessWidget {
class HomeCellState extends State<HomeCell> {
  Map PageFileInfos;
  StreamController<Map> streamController_FilesSelectAll;
  // ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  final VoidCallback CallbackFun;
  HomeCellState(this.PageFileInfos,this.CallbackFun,this.streamController_FilesSelectAll);
  //Map FileInfos = {};
  List<Widget> Containers = [];
//class HomeCell extends State {
  //const HomeCell({super.key});

  //HomeCell1(this.PageFileInfos);
  final double _file_contain_wight = 50;



  void SetSelectlPar(FileName){


    if (PageFileInfos[FileName]['selectedValue']){
      PageFileInfos[FileName]['selectedValue'] = false;
      Global.CurPage_File_Infos_Chosed.remove(FileName);
    }else{
      PageFileInfos[FileName]['selectedValue'] = true;
      Global.CurPage_File_Infos_Chosed[FileName] = PageFileInfos[FileName];
    }
    CallbackFun();
    setState(() {});
  }

  // static void setAl(){
  //   FileInfos['selectedValue']= true;
  // }


  Widget contain_bud(index){

    List PageFileInfos_list_namekey = PageFileInfos.keys.toList();
    List<int>bytes2 = base64Decode(PageFileInfos[PageFileInfos_list_namekey[index]]['filelj']);
    String CurPath = Utf8Decoder().convert(bytes2);
    Widget containi = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width -30,
            //color: Colors.yellow,

            child: GestureDetector(
              child: Row(
                children: [
                  Container(//file icon
                    height: _file_contain_wight,
                    width: 50,
                    margin: const EdgeInsets.only(right: 12.0,left:6.0),
                    child: Image(
                      height: 10,
                      width: 10,
                      fit: BoxFit.fill,
                      image: AssetImage(getFileConPath(PageFileInfos[PageFileInfos_list_namekey[index]])),
                    ),
                    //color: Colors.red,
                  ),
                  Container(//
                    height: _file_contain_wight,//file content
                    width: MediaQuery.of(context).size.width -30-50-12-6,
                    //color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(//file name

                          height: _file_contain_wight/2,
                          width: MediaQuery.of(context).size.width -30-50-12-6,
                          //color: Colors.yellow,
                          child: Text(
                            PageFileInfos[PageFileInfos_list_namekey[index]]['filename'],
                            style: const TextStyle(
                              color:Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(//file info
                          height: _file_contain_wight/2,
                          width: MediaQuery.of(context).size.width -30-50,
                          //color: Colors.yellow,
                          child: Row(
                            children: [
                              Container(//file date
                                alignment: Alignment.centerRight,
                                height: _file_contain_wight/2,
                                //width: 50,
                                //color: Colors.white,
                                margin: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  PageFileInfos[PageFileInfos_list_namekey[index]]['date'],
                                  style: const TextStyle(
                                    color:Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(//file size
                                height: _file_contain_wight/2,
                                alignment: Alignment.centerRight,
                                //width: 20,
                                //color: Colors.white,
                                child: Text(
                                  PageFileInfos[PageFileInfos_list_namekey[index]]['big'],
                                  style: const TextStyle(
                                    color:Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),



                  )
                ],
              ),
              onTap: (){
                if (Global.CurPage_File_Infos_Chosed.length>0){
                  //SetSelect(FileInfos);
                  SetSelectlPar(PageFileInfos_list_namekey[index]);
                  //SetSelectlPar(PageFileInfos_list_namekey[index]);
                }else{
                  if (PageFileInfos[PageFileInfos_list_namekey[index]]['isdir']==1){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => File_Page(CurPath)));
                  }
                }
                //print(Global.FileSelectState);


              },
            ),

          ),
          Container(//file chosed
            height: _file_contain_wight,
            width: 30,
            //color: Colors.red,
            child: Container(
              child: Container(
                child: Checkbox(
                  shape: CircleBorder(),
                  activeColor: Colors.blueAccent,
                  value: PageFileInfos[PageFileInfos_list_namekey[index]]['selectedValue'],
                  onChanged: (value) {
                    //PageFileInfos[PageFileInfos_list_namekey[index]]['selectedValue'] = value;
                    SetSelectlPar(PageFileInfos_list_namekey[index]);
                    // CallbackFun();
                    // setState(() {});
                  },
                ),
              ),
            ),

            //child: _MyRadioGroup(FileInfos),
          )
        ],
      ),
    );

    Widget Strem = StreamBuilder<Map>(
      //初始值
      initialData: PageFileInfos,
      //绑定Stream
      stream: streamController_FilesSelectAll.stream,
      builder: (context,snapshot) {
        // print(snapshot.data!);
        //
        // PageFileInfos = snapshot.data!;
        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width -30,
                //color: Colors.yellow,

                child: GestureDetector(
                  child: Row(
                    children: [
                      Container(//file icon
                        height: _file_contain_wight,
                        width: 50,
                        margin: const EdgeInsets.only(right: 12.0,left:6.0),
                        child: Image(
                          height: 10,
                          width: 10,
                          fit: BoxFit.fill,
                          image: AssetImage(getFileConPath(snapshot.data![PageFileInfos_list_namekey[index]])),
                        ),
                        //color: Colors.red,
                      ),
                      Container(//
                        height: _file_contain_wight,//file content
                        width: MediaQuery.of(context).size.width -30-50-12-6,
                        //color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(//file name

                              height: _file_contain_wight/2,
                              width: MediaQuery.of(context).size.width -30-50-12-6,
                              //color: Colors.yellow,
                              child: Text(
                                snapshot.data![PageFileInfos_list_namekey[index]]['filename'],
                                style: const TextStyle(
                                  color:Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(//file info
                              height: _file_contain_wight/2,
                              width: MediaQuery.of(context).size.width -30-50,
                              //color: Colors.yellow,
                              child: Row(
                                children: [
                                  Container(//file date
                                    alignment: Alignment.centerRight,
                                    height: _file_contain_wight/2,
                                    //width: 50,
                                    //color: Colors.white,
                                    margin: const EdgeInsets.only(right: 12.0),
                                    child: Text(
                                      snapshot.data![PageFileInfos_list_namekey[index]]['date'],
                                      style: const TextStyle(
                                        color:Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(//file size
                                    height: _file_contain_wight/2,
                                    alignment: Alignment.centerRight,
                                    //width: 20,
                                    //color: Colors.white,
                                    child: Text(
                                      snapshot.data![PageFileInfos_list_namekey[index]]['big'],
                                      style: const TextStyle(
                                        color:Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),



                      )
                    ],
                  ),
                  onTap: (){
                    if (Global.CurPage_File_Infos_Chosed.length>0){
                      //SetSelect(FileInfos);
                      SetSelectlPar(PageFileInfos_list_namekey[index]);
                      //SetSelectlPar(PageFileInfos_list_namekey[index]);
                    }else{
                      if (PageFileInfos[PageFileInfos_list_namekey[index]]['isdir']==1){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => File_Page(CurPath)));
                      }
                    }
                    //print(Global.FileSelectState);


                  },
                ),

              ),
              Container(//file chosed
                height: _file_contain_wight,
                width: 30,
                //color: Colors.red,
                child: Container(
                  child: Container(
                    child: Checkbox(
                      shape: CircleBorder(),
                      activeColor: Colors.blueAccent,
                      value: snapshot.data![PageFileInfos_list_namekey[index]]['selectedValue'],
                      onChanged: (value) {
                        //PageFileInfos[PageFileInfos_list_namekey[index]]['selectedValue'] = value;
                        SetSelectlPar(PageFileInfos_list_namekey[index]);
                        // CallbackFun();
                        // setState(() {});
                      },
                    ),
                  ),
                ),

                //child: _MyRadioGroup(FileInfos),
              )
            ],
          ),
        );
      },
    );

    return Strem;
  }



  @override
  Widget build(BuildContext context) {
    Widget list_view = ListView(children:List.generate(
        PageFileInfos.length,
        (index) => contain_bud(index)),
    );
    return list_view;
  }
}
