import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:testefl/main.dart';
import 'package:testefl/customAssets/customColorMakeAcess.dart';

class giveAcess extends StatefulWidget {
  @override
  _giveAcessState createState() => _giveAcessState();
}

class _giveAcessState extends State<giveAcess> {
  LocationData currentLocation;
  var location = new Location();
  String error;

  @override
  void initState() {
    super.initState();
  }


Future<Widget> _getAcess() async {
    var permission = await location.hasPermission();

    try{
      if(permission==false){
        while (permission==false){
          await location.requestPermission();
          await location.requestService();
          permission = await location.hasPermission();
          if(permission == true){
            return Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
          }
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image.network(
            "https://images.unsplash.com/photo-1548345680-f5475ea5df84?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80",
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Como funciona?',
                      style: TextStyle(color: customColor().white, fontSize: 36),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 300),
                      child: Text(
                        'Nós utilizamos a localização do seu dispositivo para conectá-lo com os hóspedes do Neue',
                        style: TextStyle(color: customColor().white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Além disso, você precisa estar conectado à internet para participar da comunidade.',
                style: TextStyle(color: customColor().white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              FlatButton(
                onPressed: _getAcess,
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
                    'TUDO CERTO. VAMOS COMEÇAR!',
                    style: TextStyle(
                      color: customColor().black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

