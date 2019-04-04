import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'neue',
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
                  height: 170.0,
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
