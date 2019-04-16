import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:testefl/models/person.dart';
import 'package:testefl/mainNavigation.dart';
import 'package:testefl/makeAcess.dart';
import 'package:testefl/customAssets/customColorMain.dart';
import 'package:testefl/error.dart';

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
  var currentLocation = LocationData;
  var location = new Location();
  bool verifyIfHavePermission;
  bool haveInternet  = true;
  List dataHotel;
  List dataPerson;
  Person pessoaLogada;
  final String urlApiHotel = "https://apigetrest.herokuapp.com/hotel/";
  final String urlApiPerson = "https://apigetrest.herokuapp.com/pessoa/";
  final controllerTextLogin = TextEditingController();
  final controllerPasswordLogin = TextEditingController();


  @override
  void initState(){
    try{
      this.getHotelData();
      this.getPersonData();
      super.initState();
    } catch (e) {
      print(e.toString());
    }
  }


  Future<String> getPersonData() async{
    this.verifyIfHavePermission = await location.hasPermission();
    var res = await http
        .get(Uri.encodeFull(urlApiPerson), headers: {"Accept":"application/json"});

    setState(() {
      var resBody = json.decode(utf8.decode(res.bodyBytes));
      dataPerson = resBody["results"];
    });
  }

  Future<String> getHotelData() async{

    try{
      var res = await http
          .get(Uri.encodeFull(urlApiHotel), headers: {"Accept":"application/json"});

      setState(() {
        var resBody = json.decode(res.body);
        dataHotel = resBody["results"];
        print('entrou');
        print('haveinternet é '+haveInternet.toString());
      });

    } catch(e){
      setState((){
        haveInternet = false;
      });
    }

  }

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
    controllerPasswordLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: haveInternet ? haveAcessToInternet() : errorSomethingWrongWith(context)
    );
  }

  Widget haveAcessToInternet(){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Image Background
          Image.network(
            "https://images.unsplash.com/photo-1521090029433-afd0d68460f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
            fit: BoxFit.fill,
            height: 2000.0,
            width: 2000.0,
          ),
          //Background linear gradient
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
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "neue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: customColor().white,
                          fontSize: 72.0,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 30.0,
                        ),
                      ),
                      Text(
                        'HOTEL BOUTIQUE - LIFESTYLE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: customColor().white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2.0,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height >= 550.0 ? 280.0 : 50.0,
                      ),
                      Container(
                        width: 300.0,
                        child: Column(
                          children: <Widget>[
                            Theme(
                              data: ThemeData(
                                  hintColor: customColor().white
                              ),
                              child:
                              TextField(
                                controller: controllerTextLogin,
                                style: TextStyle(color: customColor().white,),
                                decoration: InputDecoration(
                                    icon: Icon(Icons.account_circle, color: customColor().white),
                                    hintText: 'Digite seu e-mail',
                                    hintStyle: TextStyle(
                                        color: customColor().white,
                                        fontWeight: FontWeight.w200)
                                ),
                              ),
                            ),Theme(
                              data: ThemeData(
                                  hintColor: customColor().white
                              ),
                              child:
                              TextField(
                                controller: controllerPasswordLogin,
                                style: TextStyle(color: customColor().white,),
                                decoration: InputDecoration(
                                    icon: Icon(Icons.lock, color: customColor().white),
                                    hintText: 'Digite sua senha',
                                    hintStyle: TextStyle(
                                        color: customColor().white,
                                        fontWeight: FontWeight.w200)
                                ),
                                obscureText: true,
                              ),
                            ),
                            FlatButton(
                              onPressed: (){
                                if (this.verifyIfUserExist()){
                                  try{
                                    if(this.verifyIfHavePermission == true){
                                      print(this.verifyIfHavePermission);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => mainNavigation(pessoa: this.pessoaLogada),
                                          )
                                      );
                                    }
                                    else{
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => giveAcess(),
                                          )
                                      );
                                    }
                                  } catch(e){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => mainNavigation(pessoa: this.pessoaLogada),
                                    )
                                    );
                                  }
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
                              textColor: customColor().white,
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
                                      colors: [customColor().firstYellowGradient, customColor().secondYellowGradient]
                                  ),
                                ),
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(
                                    color: customColor().white,
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
                              textColor: customColor().white,
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
                                    color: customColor().white,
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
          ),

        ],
      ),
    );

  }

}
