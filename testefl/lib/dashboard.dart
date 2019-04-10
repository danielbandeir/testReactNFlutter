import 'package:flutter/material.dart';
import 'dart:core';
import 'package:testefl/models/person.dart';


class dashboard extends StatefulWidget {
  final Person pessoa;


  dashboard({Key key, @required this.pessoa}) : super(key : key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  @override
  void initState(){
    super.initState();
  }

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
                    widget.pessoa.foto,
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
                                 widget.pessoa.nome,
                                 style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w400),
                               ),
                           ),
                            Padding(
                              padding: MediaQuery.of(context).size.width < 400 ? EdgeInsets.fromLTRB(1, 0, 0, 0) : EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child:
                              Row(
                                children: <Widget>[
                                  Text(
                                    ' '+widget.pessoa.description+' ',
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    ' '+widget.pessoa.cidade+' ',
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '  -  '+widget.pessoa.estado,
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
                                       colors: [Color.fromRGBO(243,195,16, 1), Color.fromRGBO(233, 151, 4, 1)]
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
    );


  }
}
