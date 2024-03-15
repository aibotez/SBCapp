import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';


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
  const realtime_audio_recon_show({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

