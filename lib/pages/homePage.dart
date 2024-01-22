import 'package:flutter/material.dart';
import 'dynamic.dart';
import 'message.dart';
import 'category.dart';
import 'mine.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  List<Widget> _homeWidgets = [
    DynamicPage(),
    MessagePage(),
    CategoryPage(),
    MinePage(),
  ];
  void _onBottomNagigationBarTapped(index) {
    setState(() {
      _index = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     title: const Text('首页'),
      //     automaticallyImplyLeading: false),
      body: IndexedStack(
        index: _index,
        children: _homeWidgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _onBottomNagigationBarTapped,
        items: [
          _getBottomNavItem(
              '首页', 'assets/images/home.png', 'assets/images/home.png', 0),
          _getBottomNavItem(' 消息', 'assets/images/envelope.png',
              'assets/images/envelope.png', 1),
          _getBottomNavItem('分类浏览', 'assets/images/menu-burger.png',
              'assets/images/menu-burger.png', 2),
          _getBottomNavItem(
              '个人中心', 'assets/images/user.png', 'assets/images/user.png', 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _getBottomNavItem(
      String title, String normalIcon, String pressedIcon, int index) {
    return BottomNavigationBarItem(
      icon: _index == index
          ? Image.asset(
              pressedIcon,
              width: 32,
              height: 28,
            )
          : Image.asset(
              normalIcon,
              width: 32,
              height: 28,
            ),
      label: title,
    );
  }
}
