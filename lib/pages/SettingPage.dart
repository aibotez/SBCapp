import 'package:flutter/material.dart';

class settingpage extends StatelessWidget {
  //const settingpage({super.key});
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
                  Expanded(child: Text('设置')),
                ],
              ),
            ),
            Container(
              child: Text(''),
            )
          ],
        )),
      ),


    );
  }
}


