import 'package:flutter/material.dart';
import 'package:testefl/dashboard.dart';
import 'package:testefl/models/person.dart';
import 'dart:core';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:testefl/wall.dart';
import 'package:testefl/models/osInfo.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;


class mainNavigation extends StatefulWidget {
  final Person pessoa;

  @override
  _mainNavigationState createState() => _mainNavigationState();

  mainNavigation({Key key, @required this.pessoa}) : super(key : key);

}

class _mainNavigationState extends State<mainNavigation> {
  String os = Platform.operatingSystem;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  osInfo device;
  int currentIndex = 1;
  LocationData currentLocation;
  var location = new Location();
  String error;

  @override
  void initState() {
    super.initState();
    this._getCurrentLocation();
    this.getDataDevice();
  }

  Future<osInfo> getDataDevice() async{
    if(this.os == 'android'){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(androidInfo.androidId);
      return this.device = new osInfo(this.os, androidInfo.androidId, androidInfo.model, androidInfo.version.toString());
    }
    if(this.os == 'ios'){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return this.device = new osInfo(this.os, iosInfo.identifierForVendor, iosInfo.model, iosInfo.systemVersion);
    }
  }

  // pegar a localização atual
  Future<LocationData> _getCurrentLocation() async {
    var permission = await location.hasPermission();

    try {
      if (permission == true){
        currentLocation = await location.getLocation();
      }
      else{
        location.requestPermission();
        if (permission == true){
          currentLocation = await location.getLocation();
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }

      currentLocation = null;
    }
    print(currentLocation.latitude);
    print(currentLocation.longitude);
    return currentLocation;
  }


  Widget callPage(int index){
    switch(index){
      case 0 : {
        return wallProfile(pessoa: widget.pessoa);
      }
      case 1: {
        return dashboard(pessoa: widget.pessoa);
      }
      case 2: {
        return Container(
          height: 2000,
          color: Colors.yellow,
        );
      }
      case 3:{
        return Container(
          height: 2000,
          color: Colors.red,
        );
      }
      default:
        return dashboard(pessoa: widget.pessoa);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black
        ),
        child:
        BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _setCurrentLabel,
            items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.perm_media), title: Text('')),
        ]),
      ),
    );
  }

  void _setCurrentLabel(int index){
    setState(() {
      this.currentIndex = index;
    });
  }
}

