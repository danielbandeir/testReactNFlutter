import 'package:flutter/material.dart';
import 'package:testefl/customAssets/customColorMain.dart';

class errorSomethingWrong extends StatefulWidget {
  @override
  _errorSomethingWrongState createState() => _errorSomethingWrongState();
}

class _errorSomethingWrongState extends State<errorSomethingWrong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor().white,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Eita, algo deu errado')
            ],
          ),
        ],
      ),
    );
  }
}
