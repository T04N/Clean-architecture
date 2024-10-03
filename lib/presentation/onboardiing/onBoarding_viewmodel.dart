import 'dart:async';

import 'package:nvvm/presentation/base/baseviewmodel.dart';
import 'package:nvvm/presentation/domain/model.dart';
import 'package:nvvm/presentation/onboardiing/onboarding.dart';
import 'package:nvvm/presentation/resource/asset_manager.dart';
import 'package:nvvm/presentation/resource/strings_manager.dart';

class OnboardingViewmodel extends BaseViewmodel
    implements OnBoardingViewmodelInputs, OnBoardingViewmodelOutputs {
  final StreamController _streamController =
  StreamController<SlideViewObject>() ;
  late final List<SliderObject> _list;
  int _currentIndex = 0;


  List<SliderObject> _getSliderData() {
    return [
      SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubtitle1,
          ImageAssets.onboardingLogo1),
      SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubtitle2,
          ImageAssets.onboardingLogo2),
      SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubtitle3,
          ImageAssets.onboardingLogo3),
      SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubtitle3,
          ImageAssets.onboardingLogo4),
    ];
  }



  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list =  _getSliderData() ;
   _postDataToView();
  }

  @override
  void goNext() {

    print('go next');
    if (_currentIndex < _list.length - 1) {
      _currentIndex++;
    }
    _postDataToView();
  }


  @override
  void goPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }
    _postDataToView();
  }


  @override
  void onPageChanged(int indexPage) {
    // TODO: implement onPageChanged
  }

  @override
  //ADD Slide view Object to StreamController
  Sink get inputSliderViewObject => _streamController.sink;


  //output
  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SlideViewObject) => SlideViewObject);


  _postDataToView() {
    inputSliderViewObject.add(SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnBoardingViewmodelInputs {
  void goNext();

  void goPrevious();

  void onPageChanged(int indexPage);

  Sink get inputSliderViewObject; // way to add data to stream


}

abstract class OnBoardingViewmodelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;

}
