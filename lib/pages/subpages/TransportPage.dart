



import 'package:flutter/material.dart';
import 'DownPage.dart';


class TransportPage extends StatelessWidget {
  const TransportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // 设置Tab的数量
        child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              GestureDetector(child: const Icon(Icons.arrow_back_sharp),onTap: (){
                Navigator.of(context).pop();
              },),

              // Icon(Icons.arrow_back_sharp),
              Container(width: 12,),
              const Text('传输列表')
            ],),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: '下载列表'),
                Tab(text: '上传列表'),
                Tab(text: '同步列表'),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(child: DownPage()),
              Center(child: Text('Content of Tab 2')),
              Center(child: Text('Content of Tab 3')),
            ],
          ),
        ),
      ),
    );
  }
}




