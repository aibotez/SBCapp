import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';

import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';


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
  FlutterSoundPlayer playerModule = FlutterSoundPlayer();



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
    await playerModule.closePlayer();
    await playerModule.openPlayer();
    await playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));
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

        //这里我录制的是aac格式的，还有其他格式
        await recorderModule.startRecorder(
          toFile: path,
          codec: Codec.aacADTS,
          bitRate: 8000,
          numChannels: 1,
          sampleRate: 8000,
        );
        /// 监听录音
        _recorderSubscription = recorderModule.onProgress!.listen((e) {
          var date = DateTime.fromMillisecondsSinceEpoch(
              e.duration.inMilliseconds,
              isUtc: true);
          var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          //设置了最大录音时长
          if (date.second >= _maxLength) {
            _stopRecorder();
            return;
          }
          setState(() {
            //更新录音时长
            _recordText = txt.substring(1, 5);
          });
        });
        setState(() {
          //更新录音状态和录音文件路径
          _state = RecordPlayState.recording;
          _path = path;
        });
      });
    } catch (err) {
      setState(() {
        _stopRecorder();
        _state = RecordPlayState.record;
        _cancelRecorderSubscriptions();
      });
    }
  }

  /// 开始录音
  _startRecorder() async {
    try {
      var status = await getPermissionStatus();

      Directory tempDir = await getTemporaryDirectory();
      var time = DateTime.now().millisecondsSinceEpoch;
      String path =
          '${tempDir.path}}-$time${ext[Codec.aacADTS.index]}' ;

      print('===>  准备开始录音');
      await recorderModule.startRecorder(
          toFile: path,
          codec: Codec.aacADTS,
          bitRate: 8000,,
          sampleRate: 8000,,
          audioSource: AudioSource.microphone);
      print('===>  开始录音');

      /// 监听录音
      recorderModule.onProgress!.listen((e) {
        if (e != null && e.duration != null) {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.duration.inMilliseconds,
              isUtc: true);

          if (date.second >= _maxLength) {
            print('===>  到达时常停止录音');
            _stopRecorder();
          }
          setState(() {
            print("时间：${date.second}");
            print("当前振幅：${e.decibels}");
            num = date.second;
            setState(() {
              if (e.decibels! > 0 && e.decibels! < 10) {
                voiceIco = "Asset/message/icon_diyinliang.png";
              } else if (e.decibels! > 20 && e.decibels! < 30) {
                voiceIco = "Asset/message/icon_zhongyinliang.png";
              } else if (e.decibels! > 30 && e.decibels! < 40) {
                voiceIco = "Asset/message/icon_gaoyinliang.png";
              } else if (e.decibels! > 40 && e.decibels! < 50) {
                voiceIco = "Asset/message/icon_zhongyinliang.png";
              } else if (e.decibels! > 50 && e.decibels! < 60) {
                voiceIco = "Asset/message/icon_diyinliang.png";
              } else if (e.decibels! > 70 && e.decibels! < 100) {
                voiceIco = "Asset/message/icon_gaoyinliang.png";
              } else {
                voiceIco = "Asset/message/icon_diyinliang.png";
              }
            });
          });
        }
      });
      this.setState(() {
        _state = RecordPlayState.recording;
        _path = path;
        print("path == $path");
      });
    } catch (err) {
      setState(() {
        print(err.toString());
        _stopRecorder();
        _state = RecordPlayState.record;
      });
    }
  }

  /// 结束录音
  _stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      print('stopRecorder===> fliePath:$_path');
      widget.stopRecord!(_path, num);
    } catch (err) {
      print('stopRecorder error: $err');
    }
    setState(() {
      _state = RecordPlayState.play;
    });
  }
  ///开始播放，这里做了一个播放状态的回调
  void startPlayer(path, {Function(dynamic)? callBack}) async {
    try {
      if (path.contains('http')) {
        await playerModule.startPlayer(
            fromURI: path,
            codec: Codec.mp3,
            sampleRate: 44000,
            whenFinished: () {
              stopPlayer();
              callBack!(0);
            });
      } else {
        //判断文件是否存在
        if (await _fileExists(path)) {
          if (playerModule.isPlaying) {
            playerModule.stopPlayer();
          }
          await playerModule.startPlayer(
              fromURI: path,
              codec: Codec.aacADTS,
              sampleRate: 44000,
              whenFinished: () {
                stopPlayer();
                callBack!(0);
              });
        } else {}
      }
      //监听播放进度
      playerModule.onProgress!.listen((e) {});
      callBack!(1);
    } catch (err) {
      callBack!(0);
    }
  }

  /// 结束播放
  void stopPlayer() async {
    try {
      await playerModule.stopPlayer();
    } catch (err) {}
  }

  ///获取播放状态
  Future getPlayState() async {
    return await playerModule.getPlayerState();
  }

  /// 释放播放器
  void releaseFlauto() async {
    try {
      await playerModule.closePlayer();
    } catch (e) {
      print(e);
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
    playerModule.closePlayer();
  }



  @override
  Widget build(BuildContext context) {

    FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
    FlutterSoundPlayer playerModule = FlutterSoundPlayer();

    return const Placeholder();
  }
}

