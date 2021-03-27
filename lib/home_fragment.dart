import 'package:flutter/material.dart';
import 'requesters_tab_winget.dart';
import 'my_requests_tab_winget.dart';
import 'chat_widget.dart';
import 'profile_tab_widget.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}


class _HomeState extends State<Home> {

  int _currentIndex = 0;

  var tabs = [
    HomePage(),
    MyRequestsTab(),
    ChatTab(),
    ProfileTab()
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //body: _children[_currentIndex], // new
      body: tabs.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // new
        onTap: onTabTapped, // new
        items: [
          new BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/ic_icon_add.png',
              height: 24,
              width: 24,
                color: _currentIndex==0?Colors.deepOrange.shade400:Colors.blueGrey.shade700
            ),
            title: Text('Новый'),
          ),
          new BottomNavigationBarItem(
            icon: Image.asset(
                'assets/icons/ic_icon_my_data.png',
                height: 24,
                width: 24,
                color: _currentIndex==1?Colors.deepOrange.shade400:Colors.blueGrey.shade700
            ),
            title: Text('Заказы'),
          ),
          new BottomNavigationBarItem(
              icon: Image.asset(
                  'assets/icons/ic_icon_chat.png',
                  height: 24,
                  width: 24,
                  color: _currentIndex==2?Colors.deepOrange.shade400:Colors.blueGrey.shade700
              ),
              title: Text('Чат')
          ),
          new BottomNavigationBarItem(
              icon: Image.asset(
                  'assets/icons/ic_icon_profile.png',
                  height: 24,
                  width: 24,
                  color: _currentIndex==3?Colors.deepOrange.shade400:Colors.blueGrey.shade700
              ),
              title: Text('Профиль')
          )
        ],
        selectedItemColor: Colors.deepOrange.shade400,
        unselectedItemColor: Colors.blueGrey.shade700,
        showUnselectedLabels: true,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}









