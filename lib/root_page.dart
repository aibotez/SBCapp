import 'package:flutter/material.dart';
import 'pages/file_page.dart';
import 'pages/my_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  List _pages = [File_Page('/home/'),My_Page()];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        body: _pages[_currentIndex],
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
