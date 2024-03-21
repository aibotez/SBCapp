import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';

import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../pack/SBCRequest.dart';
import 'package:app/globals.dart';

import 'package:flutter/foundation.dart';




class teast extends StatelessWidget {



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
                  Expanded(child: Text('实时语音识别')),
                ],
              ),
            ),
            Container(
              child: Text(''),
            )
          ],
        )),
      ),
      body: realtime_audio_recon_show(),


    );;
  }





}


class realtime_audio_recon_show extends StatefulWidget {
  const realtime_audio_recon_show({super.key});

  @override
  State<realtime_audio_recon_show> createState() => _realtime_audio_recon_showState();
}

class _realtime_audio_recon_showState extends State<realtime_audio_recon_show> {
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  // FlutterSoundPlayer playerModule = FlutterSoundPlayer();
  String _path = '';

  bool start_record = false;
  Widget start_record_icon = Icon(Icons.not_started_outlined, size: 30, color: Colors.blue,);

  int audio_split_dur_ms = 2000;
  int sample_rate = 16000;
  List audio_data_list = [];
  String rec_conts = '';




  StreamController<String> _streamController_Date_show = StreamController();
  StreamController<String> _streamController_recon_show = StreamController();




  int _maxLength=60*60*6;




    // Map te = {'coks':SBCRe().Cookie, 'SerInfos':1, 'DiskIndex':1};
    //
    // // Map te = {'type': 'websocket.receive', 'text': '{"coks":"22@66auth:12","SerInfos":1,"DiskIndex":1}'};
    // channel.sink.add(json.encode(te));






  void init() async {

    await initializeDateFormatting();

//开启录音
    await recorderModule.openRecorder();
    // await recorderModule.setSubscriptionDuration(Duration(seconds: 1));
    //设置订阅计时器
    await recorderModule.setSubscriptionDuration(const Duration(milliseconds: 100));

    //设置音频
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

  }



  Future<bool> getPermissionStatus() async {
    Permission permission = Permission.microphone;
    //granted 通过，denied 被拒绝，permanentlyDenied 拒绝且不在提示
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      requestPermission(permission);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isRestricted) {
      requestPermission(permission);
    } else {}
    return false;
  }
  ///申请权限
  void requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }




  /// 开始录音
  _startRecorder() async {
    try {
      //获取麦克风权限
      await getPermissionStatus().then((value) async {
        if (!value) {
          return;
        }
        //用户允许使用麦克风之后开始录音
        Directory tempDir = await getTemporaryDirectory();
        var time = DateTime.now().millisecondsSinceEpoch;
        String path = '${tempDir.path}/$time${ext[Codec.aacADTS.index]}';
        print(path);
        _path = path;

        //这里我录制的是aac格式的，还有其他格式
        await recorderModule.startRecorder(

          // toStream: recordingDataController.sink,
          toFile: path,
          codec: Codec.aacADTS,
          bitRate: 256000,
          numChannels: 1,
          sampleRate: sample_rate,
          audioSource: AudioSource.microphone,
          // bufferSize:2048,
        );
        /// 监听录音
        recorderModule.onProgress!.listen((e) {
          var date = DateTime.fromMillisecondsSinceEpoch(
              e.duration.inMilliseconds,
              isUtc: true);
          var txt = DateFormat('HH:mm:ss', 'en_GB').format(date);
          // print(txt);
          _streamController_Date_show.add(txt);
          //设置了最大录音时长
          if (date.second >= _maxLength) {
            _stopRecorder();
            return;
          }



        });

      });

      this.setState(() {
        // _path = path;

      });

    } catch (err) {
      _stopRecorder();
    }
  }

  /// 结束录音
  _stopRecorder() async {
    try {
      await recorderModule.stopRecorder();

      // if (recorderModule != null) {
      //   await recorderModule!.cancel();
      //   recorderModule = null;
      // }
      print('stopRecorder===> fliePath:$_path');
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }




  /// 判断文件是否存在
  Future _fileExists(String path) async {
    return await File(path).exists();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recorderModule.closeRecorder();
    _streamController_Date_show.close();

    _streamController_recon_show.close();

  }





  @override
  Widget build(BuildContext context) {

    // FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
    // FlutterSoundPlayer playerModule = FlutterSoundPlayer();
    // connect_ws();

    init();
    // _startRecorder();

    void start_close_record(){
      if (start_record){
        start_record = false;
        start_record_icon = Icon(Icons.not_started_outlined, size: 30, color: Colors.blue,);
        _stopRecorder();

      } else{
        start_record = true;
        start_record_icon = Icon(Icons.stop_circle, size: 30, color: Colors.red,);
        _startRecorder();
      }

      setState(() {});

    }


    return Container(
      // margin: const EdgeInsets.only(top:10),
      child: Column(
        children: [

          Container(
            margin: const EdgeInsets.only(left:40),
            child: Row(children: [
              GestureDetector(child: Container(
                child: Row(
                  children: [
                    start_record_icon,
                  ],
                ),
              ),onTap: (){start_close_record();},),

              Container(
                margin: const EdgeInsets.only(left:20.0),
                child: StreamBuilder<String>(
                  //初始值
                  initialData: '00:00:00',
                  //绑定Stream
                  stream: _streamController_Date_show.stream,//snapshot.data!
                  builder: (context,snapshot) {
                    return Container(
                      //alignment: const FractionalOffset(0, 0),
                      child: Text(snapshot.data!, style: TextStyle(color: Colors.red,fontSize: 20),),
                    );
                  },
                ),
                // child: Text('..',
                //   style: TextStyle(color: Colors.red,fontSize: 20),
                // ),
              ),
            ],),
          ),
          Divider(indent: 0,endIndent: 0,),
          Expanded(child: SingleChildScrollView(child: Container(
            child: StreamBuilder<String>(
              //初始值
              initialData: '',
              //绑定Stream
              stream: _streamController_recon_show.stream,//snapshot.data!
              builder: (context,snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  //alignment: const FractionalOffset(0, 0),
                  child: Text(snapshot.data!, style: TextStyle(color: Colors.black,fontSize: 16),),
                );
              },
            ),
          ),)),

        ],
      ),
    );
  }
}
