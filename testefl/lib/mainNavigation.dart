import 'package:flutter/material.dart';
import 'package:testefl/dashboard.dart';
import 'package:testefl/models/person.dart';

class mainNavigation extends StatefulWidget {

  final Person pessoa;

  @override
  _mainNavigationState createState() => _mainNavigationState();

  mainNavigation({Key key, @required this.pessoa}) : super(key : key);

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
        print('foi pra ca');
        Navigator.push(
          context,
          // We'll create the SelectionScreen in the next step!
          MaterialPageRoute(builder: (context) => dashboard(pessoa: widget.pessoa)));
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

  @override
  void dispose() {
    super.dispose();
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

