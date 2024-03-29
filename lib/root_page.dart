import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/file_page.dart';
import 'pages/my_page.dart';

import 'globals.dart';

import 'package:flutter/services.dart' show rootBundle;




class RootPage extends StatefulWidget {
  const RootPage({super.key});


  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>{
  int _currentIndex = 0;
  List<Widget> _pages = [File_Page('/home/'),My_Page()];


  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Container(
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages,),
        // body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 15.0,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.file_present),label: '文件'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: '我的'),
          ],

          onTap: (index){
            _currentIndex = index;
            setState(() {});
          },

        ),
      ),
    );
  }
}
