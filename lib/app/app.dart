import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvvm/presentation/resource/route_manager.dart';
import 'package:nvvm/presentation/resource/theme_manager.dart';

import '../presentation/splash/splash.dart';

class AppLogic {
  // Singleton pattern cho logic quản lý ứng dụng
  static final AppLogic _instance = AppLogic._internal();

  factory AppLogic() {
    return _instance;
  }

  AppLogic._internal();

  // Các phương thức quản lý trạng thái hoặc logic của ứng dụng
  void doSomething() {
    print("Performing some logic...");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Sử dụng singleton logic từ AppLogic
    AppLogic().doSomething();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      onGenerateRoute:  RouteGenerator.getRoute ,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
