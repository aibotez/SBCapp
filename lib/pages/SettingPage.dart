import 'package:flutter/material.dart';
import '../pages/subpages/connection_setting.dart';

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
      body: SettingListViews(context: context),


    );
  }
}

class SettingListViews extends StatelessWidget {
  BuildContext context;
  SettingListViews({super.key,required this.context});

  Widget creatListView(){
    return ListView(
      children: [
        GestureDetector(

          child:Container(
              height: 40,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:10.0),

                    child: Row(
                      children: [
                        Icon(Icons.link),
                        Container(width: 10,),
                        Text('连接设置')
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right:10.0),
                    child: Icon(Icons.chevron_right,color: Colors.black26,),
                  ),
                ],
              ),

            ),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => connectionsetting()));
          },
        ),
        Divider(),
        Container(
          //color: Colors.transparent,
          height: 40,
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left:10.0),

                child: Row(
                  children: [
                    Icon(Icons.cloud_sync),
                    Container(width: 10,),
                    Text('同步设置')
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right:10.0),
                child: Icon(Icons.chevron_right,color: Colors.black26,),
              ),
            ],
          ),

        ),
        Divider(),
        GestureDetector(
          child: Container(
            //color: Colors.transparent,
            height: 40,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left:10.0),

                  child: Row(
                    children: [
                      Icon(Icons.settings_outlined),
                      Container(width: 10,),
                      Text('其它设置')
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right:10.0),
                  child: Icon(Icons.chevron_right,color: Colors.black26,),
                ),
              ],
            ),

          ),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => connectionsetting()));
          },
        ),

        Divider(),
      ],

    );
  }


  @override
  Widget build(BuildContext context) {
    return creatListView();
  }
}


