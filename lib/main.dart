import 'package:flutter/material.dart';
import 'root_page.dart';
import 'dart:io';
import 'globals.dart';
import 'package:flutter/services.dart';


import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;





Future Init_Par() async{
  String contents = await rootBundle.loadString('lib/pack/netfile');
  // print(99);
  // print(contents);
  List contlist = contents.split('\n');
  for (var i=0;i<contlist.length;i++){
    var conti = contlist[i].split('=');
    if (conti.length>1){
      if (conti[0] == 'ipport'){
        Global.ipport = conti[1];
      }
    }
  }
  return 1;

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
        }else{
          //print(snapshot.data);
          return RootPage();
          //return ListView(children: snapshot.data,);
        }
      },
    );
    // return RootPage();
  }
}

