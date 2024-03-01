import 'package:flutter/material.dart';
import 'model/car.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      );
  }
}

class Home extends StatelessWidget{
  const Home({super.key});

  Widget _itemc(BuildContext context,int index){
    return Container(
        //width: 10.0,
        height: 100.0,

        color: Colors.red,
        //color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Column(
            children: [
              Image.network(datas[index].imgurl),
              const SizedBox(height: 10,),
              Text(
                datas[index].name!,
                style: const TextStyle(
                    fontSize: 36.0
                ),

              ),
            ],
          ),


      )


      //child: Image.network(datas[index].imgurl),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('flutter test')),
        body: ListView.builder(
          itemBuilder: _itemc,
          itemCount: datas.length,
        ),
        //body: mywidget(),
    );
  }
}

class mywidget extends StatelessWidget{
  @override
  // TODO: implement widget
  Widget build(BuildContext context){
    return const Center(
      child: Text(
        'test',
        //textDirection: TextDecoration.rtl,
        style: TextStyle(
          fontSize: 36.0,
          color: Colors.red
          //fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

final List<car> datas=[
  const car('ab', 'https://hbimg.b0.upaiyun.com/77054574d5250fc093b7b4dafe09da526aeb26702265e-PAx0N0_fw658'),
  const car('bd', 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fd2fce99f-4524-49af-9c7d-4550c3ecbbf0%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1711350804&t=6f211c576c521fb2f256e6295e953da0'),


];