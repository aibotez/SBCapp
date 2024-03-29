import 'package:flutter/material.dart';
import 'SettingPage.dart';
import 'subpages/my_Applications.dart';

class My_Page extends StatefulWidget {
  const My_Page({super.key});

  @override
  State<My_Page> createState() => _My_PageState();
}

class _My_PageState extends State<My_Page> {

  // Color _themColr = Color.fromRGBO(253, 254, 254 , 1.0);
  Color _themColr = Color.fromRGBO(245, 245, 245, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor:_themColr,
          centerTitle: true,
          automaticallyImplyLeading:false,
          elevation: 0.0,
          title: Container(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //margin: const EdgeInsets.only(right: 12.0,left:6.0),
                  //padding: EdgeInsets.only(right: 30),
                  child: Row(

                    children: [
                      Icon(Icons.person),
                      Container(width: 10,),
                      // Placeholder(fallbackWidth:20,strokeWidth:0),
                      Text('zz'),
                      Container(width: 20,),
                      Container(
                        // height: 60,
                        // width: 100,
                        child: Container(
                          width: 170,
                          height: 38,

                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top:13),
                          //color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(


                            crossAxisAlignment: CrossAxisAlignment.start,

                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 150,
                                  height: 10,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all(Radius.circular(15)),
                                  // ),
                                  child: const ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    child: LinearProgressIndicator(
                                      value: 0.4,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                    ),
                                  )
                              ),
                              Container(
                                //color: Colors.red,
                                //alignment: Alignment.centerLeft,

                                child: Text(
                                  '容量：26GB/16.0TB',
                                  //textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 10,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    child: Icon(Icons.settings_outlined),
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => settingpage()));
                  },
                ),

              ],
            ),
          ),),
        body:MyPageListViews(context),
    );
  }
}

class MyPageListViews extends StatelessWidget {
  BuildContext context;
  MyPageListViews(this.context);
  // const MyPageListViews({super.key});

  Widget creatListView(){
    return ListView(
      children: [
        Container(
          //color: Colors.transparent,
          height: 50,
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left:10.0),

                child: Row(
                  children: [
                    Icon(Icons.share),
                    Container(width: 10,),
                    Text('我的分享',style: TextStyle(fontSize: 16),)
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
        Divider(indent: 10,endIndent: 17,),
        GestureDetector(child:Container(
          //color: Colors.transparent,
          height: 50,
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left:10.0),

                child: Row(
                  children: [
                    Icon(Icons.widgets),
                    Container(width: 10,),
                    Text('我的应用',style: TextStyle(fontSize: 16),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right:10.0),
                child: Icon(Icons.chevron_right,color: Colors.black26,),
              ),
            ],
          ),

        ),onTap: (){

          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => my_applications()));

        },),
        Divider(indent: 10,endIndent: 17,),
        Container(
          //color: Colors.transparent,
          height: 50,
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left:10.0),

                child: Row(
                  children: [
                    Icon(Icons.downloading),
                    Container(width: 10,),
                    Text('传输列表',style: TextStyle(fontSize: 16),)
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
        Divider(indent: 10,endIndent: 17,),
      ],

    );
  }


  @override
  Widget build(BuildContext context) {
    return creatListView();
  }
}
