import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:app/pack/SBCRequest.dart';


class preview_img extends StatelessWidget {

  String path='';

  preview_img(this.path);

  // const preview_img({super.key});


  getBse64String(path) async {
    String base64String = await SBCRe().get_img_base64(path);
    print(base64String);
    Uint8List bytes = base64Decode(base64String);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    print(path);
    getBse64String(path);
    //
    // String base64String =  getBse64String(path);
    //
    // Uint8List bytes = base64Decode(base64String);
  
    return Center(
      child: FutureBuilder(
        future: getBse64String(path),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Text('');
          }else{
            //print(snapshot.data);
            return GestureDetector(
              onTapUp: (e){
                //getChosed();

              },
              child: Image.memory(snapshot.data),
              //child: ListView(key: UniqueKey(),children: snapshot.data,),
            );
            //return ListView(children: snapshot.data,);
          }
        },
      ),
      // child: Image.memory(bytes!),
    );

    // return Container(
    //     child: PhotoView(
    //       imageProvider: NetworkImage(imgUrl),
    //     )
    // );
  }
}
