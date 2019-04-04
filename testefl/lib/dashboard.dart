import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.network(
                    "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                    height: MediaQuery.of(context).size.height*0.6,
                    width: 1000,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 1000.0,
                    height: MediaQuery.of(context).size.height*0.6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0,0.01),
                        end: Alignment.bottomCenter,
                        colors:[Color.fromRGBO(10, 10, 10, 0.2), Color.fromRGBO(20, 20, 20, 1)]
                      )
                    ),
                  ),
                ],
              ),

              //Name, description button chat
              Column(
                children: <Widget>[
                 Container(
                  width: 1000,
                  height: MediaQuery.of(context).size.height*0.3,
                  color: Color.fromRGBO(20, 20, 20, 1),
                   child: Row(
                     children: <Widget>[
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Padding(
                             padding: MediaQuery.of(context).size.width < 400 ? EdgeInsets.fromLTRB(1, 0, 0, 0) : EdgeInsets.fromLTRB(20, 0, 0, 0),
                             child:
                               Text(
                                 'Bruno B.',
                                 style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w400),
                               ),
                           ),
                            Padding(
                              padding: MediaQuery.of(context).size.width < 400 ? EdgeInsets.fromLTRB(1, 0, 0, 0) : EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child:
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Desenvolvedor Web ',
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    ' João Pessoa ',
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    ' -  PB',
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                         ],
                       ),
                       Column(
                         children: <Widget>[
                           Padding(
                             padding: MediaQuery.of(context).size.width < 400 ? EdgeInsets.fromLTRB(1, 0, 0, 0) : EdgeInsets.fromLTRB(40, 0, 0, 0),
                             child:
                             FlatButton(
                               onPressed: () {},
                               child: Container(
                                 width: MediaQuery.of(context).size.width<400 ? 50: 70,
                                 height: MediaQuery.of(context).size.width<400 ? 50: 70,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(90.0),
                                   gradient: LinearGradient(
                                       begin: Alignment.topLeft,
                                       end: Alignment.bottomRight,
                                       colors: [Color.fromRGBO(255, 205, 89, 1), Color.fromRGBO(214, 149, 0, 1)]
                                   ),
                                 ),
                                 child: Icon(
                                   Icons.chat_bubble_outline,
                                   size: MediaQuery.of(context).size.width<400 ? 22: 32,
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                  ),
                ],
              ),
            ],
          ),

          //App bar type
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor:  Colors.transparent,
                elevation: 0.0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onPressed: null,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black
        ),
        child:
          BottomNavigationBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.perm_media), title: Text('')),
      ]),
      ),

    );
  }
}
