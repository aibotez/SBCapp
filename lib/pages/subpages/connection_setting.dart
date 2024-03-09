import 'package:flutter/material.dart';
import 'dart:async';

class connectionsetting extends StatelessWidget {
  // const connectionsetting({super.key});
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
                  Expanded(child: Text('连接设置')),
                ],
              ),
            ),
            Container(
              child: Text(''),
            )
          ],
        )),
      ),
      body: connectioninput(),


    );
  }
}

class connectioninput extends StatelessWidget {
  // const connectioninput({super.key});
  String txtcontent = '';
  Map test_show={'icn':Icon(Icons.done,color: Colors.green),'txt':'','visb':false};
  StreamController<Map> _streamController_Notitestresult = StreamController();
  TextEditingController controller = new TextEditingController();


  void suretxt(){
    test_show['icn'] = Icon(Icons.done,color: Colors.green);
    test_show['txt'] = '测试通过  '+txtcontent;
    test_show['visb'] = true;
    _streamController_Notitestresult.add(test_show);
  }

  void testtxt(){
    test_show['icn'] = Icon(Icons.done,color: Colors.green);
    test_show['txt'] = '测试通过  '+txtcontent;
    test_show['visb'] = true;
    _streamController_Notitestresult.add(test_show);
  }

  @override
  void dispose() {
    //销毁
    _streamController_Notitestresult.close();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget txt = TextField(
      controller: controller,
      ///当TextField中输入的内容发生改变时回调
      onChanged: (value) {
        txtcontent = value;
        // print("TextField 中输入的内容 $value");
      },
      decoration: InputDecoration(
        hintText: "输入域名及端口, 如 pi.sbc.plus:9090",
        helperStyle:TextStyle(
          //color: Colors.red,
        ),
      ),
    );

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: txt,
          ),
          Container(
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    width: 70,
                    height: 30,
                    margin: const EdgeInsets.only(right: 20,left:30),
                    alignment: Alignment.center,
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('确认'),
                  ),
                  onTap: (){
                    suretxt();
                  },
                ),
                GestureDetector(
                  child:Container(
                    width: 70,
                    height: 30,
                    alignment: Alignment.center,
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('测试'),
                  ),
                  onTap: (){
                    testtxt();
                  },
                ),


              ],
            ),
          ),
          Container(

            child: StreamBuilder<Map>(
              //初始值
              initialData: test_show,
              //绑定Stream
              stream: _streamController_Notitestresult.stream,
              builder: (context,snapshot) {
                return Container(
                  margin: const EdgeInsets.only(right: 20,left:30,top: 30),
                  //alignment: const FractionalOffset(0, 0),

                  child: Visibility (
                      visible: snapshot.data!['visb'], // 设置是否可见：true:可见 false:不可见
                      child: Container(
                        // color: Colors.blue,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            snapshot.data!['icn'],
                            Text(snapshot.data!['txt']),
                          ],
                        ),
                        // child: Text(snapshot.data!['txt']),
                      )
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}

