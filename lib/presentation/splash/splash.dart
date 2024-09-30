import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvvm/presentation/resource/color_manager.dart';

import '../resource/asset_manager.dart';
import '../resource/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _splashViewState();
}

class _splashViewState extends State<SplashView> {

  Timer? _timer;
  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNextScreen);
  }

  _goNextScreen() {

    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary ,
        body:
        Center(
          child: Image(image: AssetImage(ImageAssets.splashLogo) ,
        )),
    );
  }
}
