import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceDeviceDetails() async {
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