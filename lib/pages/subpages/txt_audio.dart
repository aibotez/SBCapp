
import 'dart:async';

// import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:text_to_speech/text_to_speech.dart';



class txt_audio extends StatefulWidget {
  const txt_audio({super.key});

  @override
  State<txt_audio> createState() => _txt_audioState();
}

class _txt_audioState extends State<txt_audio> {


  String txt = '';

  Color _themColr = Color.fromRGBO(253, 254, 254 , 1.0);
  TextToSpeech tts = TextToSpeech();





  Future<String?> getClipboardContent() async {
    // 获取剪贴板数据
    var clipboardData = await Clipboard.getData('text/plain');
    // 打印剪贴板内容
    if (clipboardData != null) {
      print('Clipboard content: ${clipboardData.text}');
      return clipboardData.text;
    } else {
      print('Clipboard is empty.');
    }
    return '';
  }


  void player() async{
    if (txt==''){
      print(6);
      txt = (await getClipboardContent())!;
    }
    if (txt !=''){
      tts.speak(txt);
    }

  }


  
  @override
  Widget build(BuildContext context) {

    Widget Cont = Container(
      // color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: TextField(

        minLines:30,maxLines: null,
        decoration: const InputDecoration(
          hintText: '输入内容，直接播放会从粘贴板里读取',
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey), border: InputBorder.none,),
        onChanged: (value) {
          txt = value;
        },
      ),
      // child: Column(children: [Expanded(child: TextField())],),

      // child: const TextField(decoration: InputDecoration(constraints: BoxConstraints.tightForFinite(height:100)),),

    );

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
                  Expanded(child: Text('文字转语音')),
                ],
              ),
            ),
            Container(
              child: Text(''),
            )
          ],
        )),
      ),
      body: Cont,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          player();
        },
        tooltip: 'Increment',
        child: Icon(Icons.record_voice_over),

      ),


    );;
  }
}










class txt_audio_show extends StatefulWidget {

  const txt_audio_show({super.key});

  @override
  State<txt_audio_show> createState() => _txt_audio_showState();
}

class _txt_audio_showState extends State<txt_audio_show> {

  String txt = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: TextField(

        minLines:30,maxLines: null,
        decoration: InputDecoration(
          hintText: '输入内容，直接播放会从粘贴板里读取',
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey), border: InputBorder.none,),
        onChanged: (value) {
          txt = value;
        },
      ),
      // child: Column(children: [Expanded(child: TextField())],),

      // child: const TextField(decoration: InputDecoration(constraints: BoxConstraints.tightForFinite(height:100)),),

    );
  }
}

