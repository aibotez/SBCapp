import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
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
// import 'dart:math';
import 'package:flutter/foundation.dart';


class realtime_recon extends StatefulWidget {
  const realtime_recon({super.key});

  @override
  State<realtime_recon> createState() => _realtime_reconState();
}

class _realtime_reconState extends State<realtime_recon> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }



// class realtime_recon1 extends StatelessWidget {
  // const realtime_recon({super.key});

  Color _themColr = Color.fromRGBO(253, 254, 254 , 1.0);

  String value = '1';


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
              child: DropdownButton(
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(child: Text("英语",style: TextStyle(color: Colors.black),),value: "1",),
                  DropdownMenuItem(child: Text("中文",style: TextStyle(color: Colors.black),),value: "2",),
                  // DropdownMenuItem(child: Text("自动识别",style: TextStyle(color: Colors.black),),value: "3",),
                  // DropdownMenuItem(child: Text("自动识别",style: TextStyle(color: Colors.black),),value: "4",),
                ],
                hint:new Text("提示信息"),// 当没有初始值时显示
                onChanged: (selectValue){//选中后的回调
                  if (selectValue=='1'){
                    Global.Faster_ChosedLagu = 'en';
                  }else if(selectValue=='2'){
                    Global.Faster_ChosedLagu = 'zh';
                  }
                  setState(() {
                    value = selectValue!;
                  });
                },
                value: value,// 设置初始值，要与列表中的value是相同的
                elevation: 10,//设置阴影
                style: new TextStyle(//设置文本框里面文字的样式
                    color: Colors.blue,
                    fontSize: 20
                ),
                iconSize: 30,//设置三角标icon的大小
                // underline: Container(height: 1,color: Colors.blue,),// 下划线

              ),
              // child: Text('英文',style: TextStyle(fontSize: 19),),
            )
          ],
        )),
      ),
      body: realtime_audio_recon_show(),


    );;
  }
}



class realtime_audio_recon_show extends StatefulWidget {

  // String ChosedLagu;
  // realtime_audio_recon_show(this.ChosedLagu);
  const realtime_audio_recon_show({super.key});

  @override
  State<realtime_audio_recon_show> createState() => _realtime_audio_recon_showState();
}

class _realtime_audio_recon_showState extends State<realtime_audio_recon_show> {

  // String ChosedLagu;
  // _realtime_audio_recon_showState(this.ChosedLagu);


  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  // FlutterSoundPlayer playerModule = FlutterSoundPlayer();

  bool start_record = false;
  Widget start_record_icon = Icon(Icons.not_started_outlined, size: 30, color: Colors.blue,);
  int audio_split_dur_ms = 1000;
  int sample_rate = 16000;
  int byteRate=0;
  List Max_audio_data_list=[];
  List audio_data_list = [];
  String rec_conts = '';
  Map send_data_map = {'coks':'22@66auth:12', 'audio_realtime':1, 'audiodata':[],'lagu':'en'};


  StreamController<String> _streamController_Date_show = StreamController();
  StreamController<String> _streamController_recon_show = StreamController();
  WebSocketChannel channel = IOWebSocketChannel.connect(
    'ws://${Global.ipport}/getSerInfows/',
    // Uri.parse('wss://${Global.ipport}/getSerInfows/'),
    // headers: {
    //   // 'Content-Type': 'application/json; charset=UTF-8',
    //   'Cookie':'coks='+SBCRe().Cookie
    // },
  );



  int _maxLength=60*60*6;

  @override
  void initState(){
    super.initState();

    byteRate = ((16 * sample_rate * 1) / 8).round();
    print('WS_coneect_test.......');
    // Map<String, String> headers = {
    //   // 'Content-Type': 'application/json; charset=UTF-8',
    //   'Cookie':'coks='+SBCRe().Cookie
    // };
    // channel = IOWebSocketChannel.connect(
    //   'wss://${Global.ipport}/getSerInfows/',
    //   // Uri.parse('wss://${Global.ipport}/getSerInfows/'),
    //   headers: headers,
    // );

    channel.stream.listen((message) {
      print(message);
      final Map<String, dynamic> mesData = json.decode(message.toString()); // 返回
      // _streamController_recon_show.add(mesData['data']);
      if(mesData['res']==1 && mesData['data'] !=''){
        rec_conts = rec_conts+mesData['data'];
        _streamController_recon_show.add(rec_conts);
      }
      // rec_conts = rec_conts+'data\n\n\n\n\n\n\n\n\n';
      // _streamController_recon_show.add(rec_conts);

      // print('WS_coneect_test.......');
      // print(channel.ready);
      onError: (error){print('error');};
      // setState(() {
      //   // print(mesData);
      //   // String text = mesData.text;
      // });

    });



    // Map te = {'coks':SBCRe().Cookie, 'SerInfos':1, 'DiskIndex':1};
    //
    // // Map te = {'type': 'websocket.receive', 'text': '{"coks":"22@66auth:12","SerInfos":1,"DiskIndex":1}'};
    // channel.sink.add(json.encode(te));


  }


  // FlautoRecorderPlugin.attachFlautoRecorder ( ctx, registrar.messenger ()  );
  // TrackPlayerPlugin.attachTrackPlayer ( ctx, registrar.messenger ()  );
  //IOWebSocketChannel channel = ;



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





  List unittoint16(uint8List){
    final int length = uint8List.length ~/ sizeOf<Int16>();
    final Int16List int16List = Int16List(length);
    final Int16List int16List_abs = Int16List(length);
    for (int i = 0; i < length; i++) {
      int16List[i] = uint8List[i * 2 + 1] << 8 | uint8List[i * 2];
      int16List_abs[i] = int16List[i].abs();
    }
    // print(int16List); // 输出: [256,
    return [int16List,int16List_abs];// 513, 768, 1023]
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
        // String path = '${tempDir.path}/$time${ext[Codec.aacADTS.index]}';
        // print(path);
        var recordingDataController = StreamController<Food>();

        recordingDataController.stream.listen((buffer) {
          if (buffer is FoodData) {

            List auddata0 = unittoint16(buffer.data!)[0];
            List auddata0_abs = unittoint16(buffer.data!)[1];
            audio_data_list.addAll(auddata0);



            // rec_conts = rec_conts+audio_data_list.last.abs().toString()+' ';
            // _streamController_recon_show.add(rec_conts);



            final audio_data_list_max = auddata0_abs.cast<num>().reduce(max);
            Max_audio_data_list.add(audio_data_list_max);
            final audio_data_list_max_Max = Max_audio_data_list.cast<num>().reduce(max);

            if (audio_data_list.length/sample_rate>audio_split_dur_ms/1000){
              // print(auddata0_abs);
              if (audio_data_list_max > audio_data_list_max_Max/2.7){
                if(audio_data_list.length/sample_rate>3*audio_split_dur_ms/1000){
                  print('t>3s..send');
                  send_data_map['audiodata'] = audio_data_list;
                  send_data_map['lagu'] = Global.Faster_ChosedLagu;
                  channel.sink.add(json.encode(send_data_map));
                  audio_data_list = [];
                  Max_audio_data_list = [];
                }
                // print('>2.7...');
                // print(Max_audio_data_list.length);

                // print(audio_data_list_max);
                // print(audio_data_list_max_Max);

              }else if(audio_data_list_max_Max<300){
                print('clear...');
                audio_data_list = [];
                Max_audio_data_list = [];
              }else{
                print('send...');
                send_data_map['audiodata'] = audio_data_list;
                send_data_map['lagu'] = Global.Faster_ChosedLagu;
                channel.sink.add(json.encode(send_data_map));
                audio_data_list = [];
                Max_audio_data_list = [];
              }
              // print(audio_data_list.length);

            }


          }
        });

        await recorderModule.startRecorder(

        toStream: recordingDataController.sink,
          // toFile: path,
          codec: Codec.pcm16,
          // bitRate: byteRate,
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
      print('stopRecorder===> fliePath:');
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
    channel.sink.close();
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


//
// class realtime_audio_recon_show1 extends StatelessWidget {
//   // const realtime_audio_recon_show({super.key});
//   FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
//   // FlutterSoundPlayer playerModule = FlutterSoundPlayer();
//
//   bool start_record = false;
//
//   int _maxLength=6;
//   // FlautoRecorderPlugin.attachFlautoRecorder ( ctx, registrar.messenger ()  );
//   // TrackPlayerPlugin.attachTrackPlayer ( ctx, registrar.messenger ()  );
//
//
//
//   void init() async {
// //开启录音
//     await recorderModule.openRecorder();
//     //设置订阅计时器
//     await recorderModule
//         .setSubscriptionDuration(const Duration(milliseconds: 10));
//
//     //设置音频
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//       AVAudioSessionCategoryOptions.allowBluetooth |
//       AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy:
//       AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));
//
//   }
//
//
//
//   Future<bool> getPermissionStatus() async {
//     Permission permission = Permission.microphone;
//     //granted 通过，denied 被拒绝，permanentlyDenied 拒绝且不在提示
//     PermissionStatus status = await permission.status;
//     if (status.isGranted) {
//       return true;
//     } else if (status.isDenied) {
//       requestPermission(permission);
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//     } else if (status.isRestricted) {
//       requestPermission(permission);
//     } else {}
//     return false;
//   }
//   ///申请权限
//   void requestPermission(Permission permission) async {
//     PermissionStatus status = await permission.request();
//     if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }
//
//
//
//   /// 开始录音
//   _startRecorder() async {
//     try {
//       //获取麦克风权限
//       await getPermissionStatus().then((value) async {
//         if (!value) {
//           return;
//         }
//         //用户允许使用麦克风之后开始录音
//         // Directory tempDir = await getTemporaryDirectory();
//         // var time = DateTime.now().millisecondsSinceEpoch;
//         // String path = '${tempDir.path}/$time${ext[Codec.aacADTS.index]}';
//         // print(path);
//         var recordingDataController = StreamController<Food>();
//
//         recordingDataController.stream.listen((buffer) {
//           if (buffer is FoodData) {
//             List auddata0 = buffer.data!;
//
//             // List auddata = auddata0/32768.0;
//             print(auddata0);
//             // sink.add(buffer.data!);
//
//           }
//         });
//
//         //这里我录制的是aac格式的，还有其他格式
//         await recorderModule.startRecorder(
//
//           toStream: recordingDataController.sink,
//           // toFile: path,
//           codec: Codec.pcm16,
//           bitRate: 16000,
//           numChannels: 1,
//           sampleRate: 16000,
//           bufferSize:1600,
//         );
//         /// 监听录音
//         recorderModule.onProgress!.listen((e) {
//           var date = DateTime.fromMillisecondsSinceEpoch(
//
//               e.duration.inMilliseconds,
//               isUtc: true);
//           // print(e);
//           //设置了最大录音时长
//           if (date.second >= _maxLength) {
//             _stopRecorder();
//             return;
//           }
//
//         });
//
//       });
//     } catch (err) {
//       _stopRecorder();
//     }
//   }
//
//   /// 结束录音
//   _stopRecorder() async {
//     try {
//       await recorderModule.stopRecorder();
//       print('stopRecorder===> fliePath:');
//     } catch (err) {
//       print('stopRecorder error: $err');
//     }
//   }
//
//
//
//
//   /// 判断文件是否存在
//   Future _fileExists(String path) async {
//     return await File(path).exists();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     // super.dispose();
//     recorderModule.closeRecorder();
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     // FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
//     // FlutterSoundPlayer playerModule = FlutterSoundPlayer();
//
//     init();
//     // _startRecorder();
//
//     void start_close_record(){
//       if (start_record){
//         start_record = false;
//         _stopRecorder();
//
//       } else{
//         start_record = true;
//         _startRecorder();
//       }
//
//     }
//
//
//     return Container(
//       // margin: const EdgeInsets.only(top:10),
//       child: Column(
//         children: [
//
//           Container(
//             margin: const EdgeInsets.only(left:40),
//             child: Row(children: [
//               GestureDetector(child: Container(
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.not_started_outlined,
//                       size: 30,
//                       color: Colors.blue,
//                     ),
//                   ],
//                 ),
//               ),onTap: (){start_close_record();},),
//
//               Container(
//                 margin: const EdgeInsets.only(left:20.0),
//                 child: Text('..',
//                   style: TextStyle(color: Colors.red,fontSize: 20),
//                 ),
//               ),
//             ],),
//           ),
//           Divider(indent: 0,endIndent: 0,),
//           Container(),
//         ],
//       ),
//     );
//   }
// }




