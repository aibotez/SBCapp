import 'package:flutter/material.dart';

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
  TextEditingController controller = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    Widget txt = TextField(
      controller: controller,
      ///当TextField中输入的内容发生改变时回调
      onChanged: (value) {
        print("TextField 中输入的内容 $value");
      },
      decoration: InputDecoration(
        hintText: "输入域名及端口, 如 pi.sbc.plus:9090",
        helperStyle:TextStyle(
          color: Colors.red,
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
                Container(
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
                Container(
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
              ],
            ),
          ),

        ],
      ),
    );
  }
}

