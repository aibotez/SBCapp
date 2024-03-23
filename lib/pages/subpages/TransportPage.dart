



import 'package:flutter/material.dart';
import 'DownPage.dart';


class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('recommend initState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('Transp....');
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




