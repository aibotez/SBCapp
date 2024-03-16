import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';

import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/foundation.dart';


class realtime_recon extends StatelessWidget {
  // const realtime_recon({super.key});

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







class realtime_audio_recon_show extends StatelessWidget {
  // const realtime_audio_recon_show({super.key});
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  // FlutterSoundPlayer playerModule = FlutterSoundPlayer();

  int _maxLength=6;
  // FlautoRecorderPlugin.attachFlautoRecorder ( ctx, registrar.messenger ()  );
  // TrackPlayerPlugin.attachTrackPlayer ( ctx, registrar.messenger ()  );



  void init() async {
//开启录音
    await recorderModule.openRecorder();
    //设置订阅计时器
    await recorderModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));

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





  Future<bool> getPermissionStatus1() async {
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
        var recordingDataController = StreamController<Food>();

        recordingDataController.stream.listen((buffer) {
          if (buffer is FoodData) {
            print(buffer.data!);
            // sink.add(buffer.data!);
          }
        });

        //这里我录制的是aac格式的，还有其他格式
        await recorderModule.startRecorder(

          toStream: recordingDataController.sink,
          // toFile: path,
          codec: Codec.pcm16,
          bitRate: 16000,
          numChannels: 1,
          sampleRate: 16000,
          bufferSize:1600,
        );
        /// 监听录音
        recorderModule.onProgress!.listen((e) {
          var date = DateTime.fromMillisecondsSinceEpoch(

              e.duration.inMilliseconds,
              isUtc: true);
          // print(e);
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
    // super.dispose();
    recorderModule.closeRecorder();

  }



  @override
  Widget build(BuildContext context) {

    FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
    FlutterSoundPlayer playerModule = FlutterSoundPlayer();

    init();
    _startRecorder();


    return const Placeholder();
  }
}

