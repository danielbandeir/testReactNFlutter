import 'package:flutter/material.dart';
import 'package:testefl/models/person.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;


class dashboard extends StatefulWidget {
  final Person pessoa;

  dashboard({Key key, @required this.pessoa}) : super(key : key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  List interests;
  List friends;
  final String urlInterests = "http://apigetrest.herokuapp.com/interesses/";
  final String urlFriends = "http://apigetrest.herokuapp.com/amigos/";

  @override
  void initState(){
    SystemChrome.setEnabledSystemUIOverlays([]);
    this.getInterests();
    this.getFriends();
    super.initState();
  }


  Future<String> getInterests() async{
    var res = await http
        .get(Uri.encodeFull(urlInterests), headers: {"Accept":"application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      interests= resBody["results"];
    });
  }

  Future<String> getFriends() async{
    var res = await http
        .get(Uri.encodeFull(urlFriends), headers: {"Accept":"application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      friends = resBody["results"];
    });
  }


  List<Widget> listInterests(BuildContext context){
    var interestGroup = new List<Widget>();
    int i=0;

    while (interests.length>i){
      if(interests.length-i>1){
        interestGroup.add(
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Container(
                  height: 25,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Text(interests[i]['nome'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white ,width: 1)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Container(
                  height: 25,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Text(interests[i+1]['nome'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white ,width: 1)
                  ),
                ),
              )
            ],
          ),
        );
        i+=2;
      }
      else{
        interestGroup.add(
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Container(
                  height: 25,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Text(interests[i]['nome'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white ,width: 1)
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      }
    }
    return interestGroup;
  }

//widget com listView que pega o listInterests onde pega todos os interesses
  Widget interessesPessoais(){
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Column(
                children: <Widget>[
                  Text(
                      "Interesses na cidade",
                      style: TextStyle(color: Colors.grey, fontSize: 16)
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: interests != null ? listInterests(context) : <Widget>[CircularProgressIndicator()],
            ),
          ),
        ),
      ],
    );
  }

List<Widget> listAmigosEmComum(BuildContext context){
    var instanceFriends = new List<Widget>();
    print(friends.length);
    for(int i=0; i<friends.length;i++){
      instanceFriends.add(
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.yellow,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(friends[i]['foto']),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return instanceFriends;
}

 //Widget com listView que pega todos os amigos em comum
  Widget amigosEmComum(){
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Column(
                children: <Widget>[
                  Text(
                      "Amigos em comum",
                      style: TextStyle(color: Colors.grey, fontSize: 16)
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: friends != null ? listAmigosEmComum(context) : <Widget>[CircularProgressIndicator()],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 20, 20, 1),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
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
                        height: MediaQuery.of(context).size.height*0.1,
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
                  interessesPessoais(),
                  amigosEmComum(),
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
        ],
      ),

    );


  }
}
