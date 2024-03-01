import 'package:flutter/material.dart';
import '../pages/file_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pack/getfileconpath.dart';
import 'package:app/globals.dart';

// import 'package:app/globals.dart' as globals;


void SetGilbalPar(FileInfos){
  if (Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue']){
    Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue'] = false;
    //Global.FileSelectState = Global.FileSelectState-1;
    Global.CurPage_File_Infos_Chosed.remove(FileInfos['filename']);

  }
  else{
    Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue'] = true;
    //Global.FileSelectState = Global.FileSelectState+1;
    Global.CurPage_File_Infos_Chosed[FileInfos['filename']]=FileInfos;
  }
}


class HomeCell extends StatefulWidget {
  Map PageFileInfos;
  HomeCell(this.PageFileInfos);
  //const HomeCell({super.key});

  @override
  State<HomeCell> createState() => _HomeCellState(PageFileInfos);
}

class _HomeCellState1 extends State<HomeCell> {
  Map PageFileInfos;
  _HomeCellState1(this.PageFileInfos);
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


//class HomeCell1 extends StatelessWidget {
class _HomeCellState extends State<HomeCell> {
  _HomeCellState(this.PageFileInfos);
//class HomeCell extends State {
  //const HomeCell({super.key});

  Map PageFileInfos;

  //HomeCell1(this.PageFileInfos);
  final double _file_contain_wight = 50;




  void SetSelect(FileInfos){
    //print(Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue']);
    // if (Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue']){
    //   Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue'] = false;
    //   Global.FileSelectState = Global.FileSelectState-1;
    //   Global.CurPage_File_Infos_Chosed[FileInfos['filename']]=FileInfos;
    // }
    // else{
    //   Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue'] = true;
    //   Global.FileSelectState = Global.FileSelectState+1;
    //   Global.CurPage_File_Infos_Chosed.remove(FileInfos['filename']);
    // }
    // print(Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue']);
    SetGilbalPar(FileInfos);
    setState(() {});

  }



  @override
  Widget build(BuildContext context) {
    Map FileInfos = PageFileInfos['FileInfos'];
    List<int>bytes2 = base64Decode(FileInfos['filelj']);
    String CurPath = Utf8Decoder().convert(bytes2);
    //print(FileInfos);

    //Widget ee = _MyRadioGroup(FileInfos);
    //print(9);
    //print(ee.);

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
                      image: AssetImage(getFileConPath(PageFileInfos)),
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
                            FileInfos['filename'],
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
                                  FileInfos['date'],
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
                                  FileInfos['big'],
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

                //getDatas();
                //Global.CurPage_File_Infos_Chosed = {};
                // print(FileInfos);
                //print('click..'+FileInfos['filename']);
                //print(Global.CurPage_File_Infos_Chosed);


                if (Global.CurPage_File_Infos_Chosed.length>0){
                  //SetSelect(FileInfos);
                  SetSelect(FileInfos);

                }else{
                  if (FileInfos['isdir']==1){
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
              child: _MyRadioGroup(FileInfos),

              // child1: Checkbox(
              //   shape: CircleBorder(),
              //   activeColor: Colors.blueAccent,
              //   value: Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue'],
              //   onChanged: (value) {
              //
              //     if (value!){
              //       Global.FileSelectState = Global.FileSelectState+1;
              //     }
              //     else{
              //       Global.FileSelectState = Global.FileSelectState-1;
              //     }
              //     Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue']=value;
              //     Global.CurPage_File_Infos_Chosed[FileInfos['filename']]=FileInfos;
              //     setState(() {});
              //     print(Global.FileSelectState);
              //
              //   },
              // ),
            ),

            //child: _MyRadioGroup(FileInfos),
          )
        ],
      ),
    );
  }
}



class _MyRadioGroup extends StatefulWidget {
  Map FileInfos;
  _MyRadioGroup(this.FileInfos);


  @override
  _MyRadioGroupState createState() => _MyRadioGroupState(FileInfos);
}

class _MyRadioGroupState extends State<_MyRadioGroup> {
  Map FileInfos;
  _MyRadioGroupState(this.FileInfos);
  bool _selectedValue = false;
  //Map FileInfos;
  //HomeCell File_Infos;




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Checkbox(
        shape: CircleBorder(),
        activeColor: Colors.blueAccent,

        value: Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue'],
        //value: _selectedValue,
        //value: _selectedValue,
        onChanged: (value) {

          SetGilbalPar(FileInfos);

          // //print(_selectedValue);
          // _selectedValue = value!;
          // //print(_selectedValue);
          //
          // if (value){
          //   Global.FileSelectState = Global.FileSelectState+1;
          //   Global.CurPage_File_Infos_Chosed[FileInfos['filename']]=FileInfos;
          // }
          // else{
          //   Global.FileSelectState = Global.FileSelectState-1;
          //   Global.CurPage_File_Infos_Chosed.remove(FileInfos['filename']);
          // }
          //
          // Global.CurPage_File_Infos[FileInfos['filename']]['selectedValue']=_selectedValue;
          // FileInfos['FileChosed']=_selectedValue;
          // print(Global.CurPage_File_Infos_Chosed);
          setState(() {});

        },
      ),
    );


  }
}


