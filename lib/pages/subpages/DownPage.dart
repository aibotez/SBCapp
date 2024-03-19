import 'package:flutter/material.dart';


class DownPage extends StatefulWidget {
  const DownPage({super.key});

  @override
  State<DownPage> createState() => _DownPageState();
}

class _DownPageState extends State<DownPage> {


  Widget getDowns(){
    Widget rowi = Row();

    return rowi;
  }


  @override
  Widget build(BuildContext context) {

    Widget cont = Container(
      child: Column(children: [
        Container(child: Text('xx'),),

        Container(
          child: Row(),
        ),


      ],),
    );



    return cont;
  }
}
