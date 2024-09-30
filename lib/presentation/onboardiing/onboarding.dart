import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nvvm/presentation/resource/asset_manager.dart';
import 'package:nvvm/presentation/resource/color_manager.dart';
import 'package:nvvm/presentation/resource/strings_manager.dart';
import 'package:nvvm/presentation/resource/value_manager.dart';

class SliderObject {
  SliderObject(this.title, this.subTitle, this.image);
  String title;
  String subTitle;
  String image;
}

class onboardingView extends StatefulWidget {
  const onboardingView({super.key});

  @override
  State<onboardingView> createState() => _onnboardingViewState();
}

class _onnboardingViewState extends State<onboardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  late final List<SliderObject> _list = _getSliderData();

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
  int _getPreviousIndex() {
    if (_currentIndex == 0) return _currentIndex;
    return --_currentIndex;  // Pre-decrement to correctly reduce the index
  }

  int _getNextIndex() {
    if (_currentIndex == _list.length - 1) return _currentIndex;
    return ++_currentIndex;  // Pre-increment to correctly advance the index
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (int page) {
          setState(() {
            _currentIndex = page;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return OnBoardingPage(sliderObject: _list[index]);
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: AppSize.s100,
        child: Column(
          children: [
            // Skip button aligned to the right
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add action for skipping onboarding
                },
                child: const Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            // Add Bottom Sheet widget here
            _getBottomSheetWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.leftArrowIc),
            ),
            onTap: () {
              _pageController.animateToPage(_getPreviousIndex(), duration:Duration(microseconds: DurationConstant.d300) , curve: Curves.bounceInOut);
            },
          ),

        ),

        Row(
          children: List.generate(_list.length, (int i) {
            return Padding(
              padding: EdgeInsets.all(AppPadding.p8),
              child: _getProperCicrle(i),
            );
          }),
        )
        ,


        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightarrowIc),
            ),
            onTap: () {
              _pageController.animateToPage(_getNextIndex(), duration:Duration(microseconds: DurationConstant.d300) , curve: Curves.bounceInOut);
            },
          ),
        )
      ],
    );
  }



  Widget _getProperCicrle(int indexPage ) {
    if ( _currentIndex ==indexPage ) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else return SvgPicture.asset(ImageAssets.solidCircleIc);
  }
}



class OnBoardingPage extends StatelessWidget {
  SliderObject sliderObject;

  OnBoardingPage({required this.sliderObject, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s40,
        ),
        SvgPicture.asset(sliderObject.image),

      ],
    );
  }
}
