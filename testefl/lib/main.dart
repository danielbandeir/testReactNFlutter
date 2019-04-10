import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:testefl/models/person.dart';
import 'package:testefl/mainNavigation.dart';
import 'package:testefl/makeAcess.dart';

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
  List dataHotel;
  List dataPerson;
  Person pessoaLogada;
  final String urlApiHotel = "https://apigetrest.herokuapp.com/hotel/";
  final String urlApiPerson = "https://apigetrest.herokuapp.com/pessoa/";

  @override
  void initState(){
    super.initState();
    this.getHotelData();
    this.getPersonData();
  }


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


//verifica se o usuário digitado existe e passa os dados de login caso ele exista, sem precisar chamar novamente o JSON.
 bool verifyIfUserExist(){
      String user = controllerTextLogin.text;
      String password = controllerPasswordLogin.text;

      print(this.dataPerson.length);

      for(int i=0; i<this.dataPerson.length ; i++){
        if (this.dataPerson[i]["nome"] == user){
          if (this.dataPerson[i]["senha"] == password){
            pessoaLogada = new Person(this.dataPerson[i]['url'], this.dataPerson[i]['nome'], this.dataPerson[i]['senha'], this.dataPerson[i]['description'], this.dataPerson[i]['cidade'], this.dataPerson[i]['estado'], this.dataPerson[i]['foto']);
            return true;
          }
        }
      }
      return false;
 }

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
            "https://images.unsplash.com/photo-1521090029433-afd0d68460f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
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
                  "neue",
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
                          if (this.verifyIfUserExist()){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => mainNavigation(pessoa: this.pessoaLogada),
                           )
                          );
                          }
                          else {
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
                                          'Credenciais erradas, desculpe =/'
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          }
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => giveAcess(),
                              )
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
