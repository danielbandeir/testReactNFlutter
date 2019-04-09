import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';

class osInfo {
  String os = Platform.operatingSystem;

  String idOS;
  String versionOS;
  String modelOS;

  osInfo(this.idOS, this.versionOS, this.modelOS);

  String getIdOS() {

  }

  ;
}