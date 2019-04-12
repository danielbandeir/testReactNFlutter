import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;

class seeProfile extends StatefulWidget {
  @override
  _seeProfileState createState() => _seeProfileState();
}

class _seeProfileState extends State<seeProfile> {
  List friends;
  final String urlFriends = "http://apigetrest.herokuapp.com/amigos/";

  @override
  void initState() {
    this.getFriends();
    super.initState();
  }

  Future<String> getFriends() async{
    var res = await http
        .get(Uri.encodeFull(urlFriends), headers: {"Accept":"application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      friends = resBody["results"];
    });
  }

  //Widget com listView que pega todos os amigos em comum
  List<Widget> amigosEmComum(int numberPersonsPerRow){
    var persons = new List<Widget>();

        for(int i =0; i<friends.length;i++){
          persons.add(
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width/(numberPersonsPerRow+1),
                  height: MediaQuery.of(context).size.width/(numberPersonsPerRow+1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        );

        }

        return persons;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 20, 20, 1),
      body: Stack(
        //ImageBackPrimeiro, pessoas, linear gradient
        children: <Widget>[
          Image.network(
            "https://images.unsplash.com/photo-1521090029433-afd0d68460f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromRGBO(10, 10, 10, 0.5), Color.fromRGBO(20, 20, 20, 1)]
              ),
            ),
          ),
          //App bar type
          ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: friends != null ? amigosEmComum(3) : <Widget>[CircularProgressIndicator()],
          ),
          Column(
            children: <Widget>[
              AppBar(
                title: Text("Pessoas"),
                backgroundColor:  Colors.transparent,
                elevation: 0.0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white),
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
