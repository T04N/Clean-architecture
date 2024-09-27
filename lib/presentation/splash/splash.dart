import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvvm/presentation/resource/color_manager.dart';

import '../resource/asset_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _splashViewState();
}

class _splashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary ,
        body: Image(image: AssetImage(ImageAssets.splashlogo))
    );
  }
}
