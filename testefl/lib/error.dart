import 'package:flutter/material.dart';
import 'package:testefl/customAssets/customColorError.dart';
import 'package:testefl/main.dart';


@override
Widget errorSomethingWrongWith(BuildContext context){
  return Scaffold(
    backgroundColor: customColor().white,
    body: Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Oops!',
              style: TextStyle(color: customColor().grey, fontSize:48, fontWeight: FontWeight.bold)
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,20,30),
                child:
                Text('Parece que ocorreu algum erro, por favor veja se você está conectado com a internet e tente novamente =D',textAlign: TextAlign.center),
              ),
              FlatButton(
                onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  try{
                    return MyApp();
                  } catch (e){
                    return errorSomethingWrongWith(context);
                  }
                })); },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: customColor().grey,
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0,10,0),
                          child: Icon(Icons.report, color: customColor().white),
                        ),
                        Text('Tente novamente!', style: TextStyle(color: customColor().white))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}