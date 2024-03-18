import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'root_page.dart';
import 'dart:io';
import 'globals.dart';
// import 'package:flutter/services.dart';

import 'pack/dboper.dart';


import 'dart:async' show Future;
// import 'package:flutter/services.dart' show rootBundle;





void main_test() {
  final file = File('lib/pack/netfile');
  final contents = file.readAsStringSync();
  print(999);
  print(contents);
}


Future Init_Par() async{
  // main_test();

  // MyDatabase();
  // var mydata = MyDatabase();
  // Global.db = mydata.db;

  // String contents = await rootBundle.loadString('lib/pack/netfile');
  // // print(99);
  // // print(contents);
  // List contlist = contents.split('\n');
  // for (var i=0;i<contlist.length;i++){
  //   var conti = contlist[i].split('=');
  //   if (conti.length>1){
  //     if (conti[0] == 'ipport'){
  //       Global.ipport = conti[1];
  //     }
  //   }
  // }

  var mydata = MyDatabase();
  // mydata.init();
  List netconfigs = await mydata.init();
  Global.ipport = netconfigs[0]['ipport'];
  print(netconfigs);
  // mydata.closebase();
  // await MyDatabase().getdata().then((value) => print(value));
  // print(netconfigs);
  // List netconfigs=[];


  // Global.db=MyDatabase();
  return netconfigs;

}



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,//是Flutter的一个本地化委托，用于提供Material组件库的本地化支持
          GlobalWidgetsLocalizations.delegate,//用于提供通用部件（Widgets）的本地化支持
          GlobalCupertinoLocalizations.delegate,//用于提供Cupertino风格的组件的本地化支持
        ],
      supportedLocales: [
        const Locale('zh', 'CN'),// 支持的语言和地区
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init_Par(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Text('');
        }
        else{
          // print(Global.db.dbpath);
          // print(snapshot.data);
          // Global.db=MyDatabase();
          // print(Global.db.dbpath);
          // return Text('');
          return RootPage();
          //return ListView(children: snapshot.data,);
        }
      },
    );
    // return RootPage();
  }
}

