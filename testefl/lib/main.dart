import 'package:flutter/material.dart';
import 'package:testefl/dashboard.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'neue',
      home: Login(),
    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState(){
    super.initState();
    this.getHotelData();
    this.getPersonData();
  }

  final String urlApiHotel = "https://apigetrest.herokuapp.com/hotel/";
  List dataHotel;

  final String urlApiPerson = "https://apigetrest.herokuapp.com/pessoa/";
  List dataPerson;

  Future<String> getPersonData() async{
    var res = await http
        .get(Uri.encodeFull(urlApiPerson), headers: {"Accept":"application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      dataPerson = resBody["results"];
    });
  }

  Future<String> getHotelData() async{
    var res = await http
        .get(Uri.encodeFull(urlApiHotel), headers: {"Accept":"application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      dataHotel = resBody["results"];
    });
  }

  final controllerTextLogin = TextEditingController();
  final controllerPasswordLogin = TextEditingController();



  @override
  void dispose(){
    controllerTextLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image.network(
            dataHotel[0]['background_image'],
            fit: BoxFit.cover,
            height: 2000.0,
          ),
          Container(
            height: 3000.0,
            width: 3000.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(10, 10, 10, 0.5), Color.fromRGBO(20, 20, 20, 1)]
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  dataHotel[0]['nome'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 72.0,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 30.0,
                  ),
                ),
                Text(
                  'HOTEL BOUTIQUE - LIFESTYLE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2.0,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height >= 550.0 ? 220.0 : 50.0,
                ),
                Container(
                  width: 300.0,
                  child: Column(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                            hintColor: Colors.white
                        ),
                        child:
                        TextField(
                          controller: controllerTextLogin,
                          style: TextStyle(color: Colors.white,),
                          decoration: InputDecoration(
                              icon: Icon(Icons.account_circle, color: Colors.white),
                              hintText: 'Digite seu e-mail',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)
                          ),
                        ),
                      ),Theme(
                        data: ThemeData(
                            hintColor: Colors.white
                        ),
                        child:
                        TextField(
                          controller: controllerPasswordLogin,
                          style: TextStyle(color: Colors.white,),
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock, color: Colors.white),
                              hintText: 'Digite sua senha',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)
                          ),
                          obscureText: true,
                        ),
                      ),
                      FlatButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => dashboard(urlPerson: dataPerson[0]['url']))
                          );
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color.fromRGBO(243,195,16, 1), Color.fromRGBO(233, 151, 4, 1)]
                            ),
                          ),
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 5.0,
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: (){
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  width: 300,
                                  height: 40,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        controllerTextLogin.text,
                                      ),
                                      Text(
                                        controllerPasswordLogin.text,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color.fromRGBO(59, 89, 152, 1), Color.fromRGBO(78, 113, 186, 1)]
                            ),
                          ),

                          child: Text(
                              'ENTRAR COM FACEBOOK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
