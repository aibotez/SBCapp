import 'package:flutter/material.dart';
import 'package:app/globals.dart';

class FileChosedTopShow extends StatefulWidget {
  const FileChosedTopShow({super.key});

  @override
  State<FileChosedTopShow> createState() => FileChosedTopShowState();
}

class FileChosedTopShowState extends State<FileChosedTopShow> {


  void showtop(){
    setState(() {
      Global.FileChoseBarNotiOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const FractionalOffset(0, 0),

      child: Visibility (
          visible: Global.FileChoseBarNotiOpen, // 设置是否可见：true:可见 false:不可见
          child: Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: Text('test'),
          )
      ),
    );
  }
}
