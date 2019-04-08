import 'package:flutter/material.dart';

class mainNavigation extends StatefulWidget {
  @override
  _mainNavigationState createState() => _mainNavigationState();
}

class _mainNavigationState extends State<mainNavigation> {
  int currentIndex = 1;


  @override
  void initState() {
    super.initState();
  }


  Widget callPage(int index){
    switch(index){
      case 0 : {
        print('mural');
        break;
      }
      case 1: {
        print('perfil');
        break;
      }
      case 2: {
        print('chat');
        break;
      }
      case 3:{
        print('achivement');
        break;
      }
      default:{
        print('perfil');
      }
    }
  }


  void _onItemTaped(int index){
    setState((){
      currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black
        ),
        child:
        BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onItemTaped,
            items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.perm_media), title: Text('')),
        ]),
      ),
    );
  }
}

