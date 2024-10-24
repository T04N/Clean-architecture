import 'dart:io';

import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String nameDevice = "Unknown";
  String indentifier = "Unknown";
  String version = "Unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();



  try {
    if (Platform.isAndroid) {
      var buildInfo = await deviceInfoPlugin.androidInfo;
      nameDevice = buildInfo.brand + " " + buildInfo.model;
      indentifier = buildInfo.id;
      version = buildInfo.version.toString();

    } else if (Platform.isIOS) {

    }
  } on PlatformException {
    return DeviceInfo(nameDevice, indentifier, version);
  }
  return DeviceInfo(nameDevice, indentifier, version) ;
}

bool isEmailValid(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}