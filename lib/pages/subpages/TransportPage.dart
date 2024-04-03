



import 'package:flutter/material.dart';
import 'DownPage.dart';


class TransportPage extends StatefulWidget {

  List SelectFiles;
  TransportPage(this.SelectFiles);
  // const TransportPage({super.key});


  @override
  State<TransportPage> createState() => _TransportPageState(SelectFiles);
}

class _TransportPageState extends State<TransportPage> with AutomaticKeepAliveClientMixin<TransportPage> {

  List SelectFiles;
  _TransportPageState(this.SelectFiles);

  @override
  bool get wantKeepAlive => true;

  int _currentIndex = 0;
  List<Widget> _pages = [DownPage(),Text('Content of Tab 2'),Text('Content of Tab 3')];

  @override
  void initState() {
    super.initState();
    print('recommend initState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // print('Transp....');
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
            bottom: TabBar(
              tabs: const <Widget>[
                Tab(text: '下载列表'),
                Tab(text: '上传列表'),
                Tab(text: '同步列表'),
              ],
              onTap:(index) {
                _currentIndex = index;
                setState(() {});
              },


            ),
          ),
          body: IndexedStack(index: _currentIndex, children: _pages,),



        ),
      ),
    );



  }
}




