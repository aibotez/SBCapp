import 'package:flutter/material.dart';
import 'root_page.dart';
import 'dart:io';
import 'globals.dart';
import 'package:flutter/services.dart';

import 'pack/dboper.dart';


import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;





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
  List netconfigs = await mydata.getdata();
  // await MyDatabase().getdata().then((value) => print(value));
  print(netconfigs);
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
          print(snapshot.data);
          // Global.db=MyDatabase();
          // print(Global.db.dbpath);
          return Text('');
          // return RootPage();
          //return ListView(children: snapshot.data,);
        }
      },
    );
    // return RootPage();
  }
}

