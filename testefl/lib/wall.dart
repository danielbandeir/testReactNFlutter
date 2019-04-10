import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class wallProfile extends StatefulWidget {
  @override
  _wallProfileState createState() => _wallProfileState();
}

class _wallProfileState extends State<wallProfile> {
  List dataComment;
  final String urlApiComments = "http://apigetrest.herokuapp.com/comentario/";


  Future<String> getCommentData() async{
    var res = await http
        .get(Uri.encodeFull(urlApiComments), headers: {"Accept":"application/json"});

    setState( (){
      var resComment = json.decode(res.body);
      dataComment = resComment["results"];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getCommentData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mural do Daniel",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:  Colors.black,
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
      body: Stack(
        children: <Widget>[
          Container(
            height: 2000,
            color: Colors.black,
          ),
          ListView.builder(
            itemCount: dataComment.length,
            itemBuilder: (BuildContext context, int i) {
              return Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column( //button more vertical for comment info
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                            color: Colors.white,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 50,
                            height: 200,
                            child: Stack(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                          Icons.more_vert, color: Colors.grey),
                                      onPressed: () {
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                        "Testando"
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                      //alinhamento da imagem ícone do NOme user
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius
                                                      .circular(90),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        dataComment[i]['foto']
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding( //Padding da imagem do icone para o nome o usuário
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 0, 0, 0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(dataComment[i]['nomePessoa']),
                                                    Text(dataComment[i]['tempo'])
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Text(
                                              dataComment[i]['texto'],
                                              maxLines: 5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 100,
                                            height: 40,
                                            child: Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.favorite,
                                                      color: Colors.red),
                                                  onPressed: null,
                                                ),
                                                Text(
                                                  "Curtido",
                                                  style: TextStyle(
                                                      color: Colors.red),)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150,
                                            height: 40,
                                            child: Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.comment,
                                                      color: Colors.grey),
                                                  onPressed: null,
                                                ),
                                                Text("20 comentários")
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              );
            }
          ),

        ],
      ),
    );
  }
}
