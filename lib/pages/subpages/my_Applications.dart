// import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'realtime_audio_recon.dart';
import 'txt_audio.dart';
import 'realtime_test.dart';


class my_applications extends StatelessWidget {
  // const my_applications({super.key});

  Color _themColr = Color.fromRGBO(253, 254, 254 , 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor:_themColr,
        centerTitle: true,
        automaticallyImplyLeading:false,
        elevation: 0.0,
        title: Container(child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              //color: Colors.red,
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back),
                    onTap:(){Navigator.of(context).pop();},
                  ),
                  Container(width: 10,),
                  Expanded(child: Text('应用列表')),
                ],
              ),
            ),
            Container(
              child: Text(''),
            )
          ],
        )),
      ),
      body: apps_show(),


    );;
  }
}

class apps_show extends StatelessWidget {
  const apps_show({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      padding: EdgeInsets.only(top:13),
      maxCrossAxisExtent: 100, //主要。横轴子元素为固定最大长度(自动计算)
      children: [
        GestureDetector(child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left:10.0),
          padding: EdgeInsets.only(top:13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(children: [
            Container(child: Image(
              height: 60,
              width: 60,
              fit: BoxFit.fill,
              image: AssetImage('src/img/spech.jfif'),
            ),),
            Text('实时语音识别',style: TextStyle(fontSize: 10),)
          ],),
        ),onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => realtime_recon()));

        },),

        // Container(width: 1,),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left:10.0),
          padding: EdgeInsets.only(top:13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(children: [
            Container(child: Image(
              height: 60,
              width: 60,
              fit: BoxFit.fill,
              image: AssetImage('src/img/vido.jfif'),
            ),),
            Text('实时录制',style: TextStyle(fontSize: 10),)
          ],),
        ),

        GestureDetector(child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left:10.0),
          padding: EdgeInsets.only(top:13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(children: [
            Container(child: Image(
              height: 60,
              width: 60,
              fit: BoxFit.fill,
              image: AssetImage('src/img/txt_audio.png'),
            ),),
            Text('文字转语音',style: TextStyle(fontSize: 10),)
          ],),
        ),onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => txt_audio()));

        },),


      ],
    );

  }
}

