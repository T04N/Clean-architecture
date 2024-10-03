import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nvvm/presentation/domain/model.dart';
import 'package:nvvm/presentation/onboardiing/onBoarding_viewmodel.dart';
import 'package:nvvm/presentation/resource/asset_manager.dart';
import 'package:nvvm/presentation/resource/color_manager.dart';
import 'package:nvvm/presentation/resource/strings_manager.dart';
import 'package:nvvm/presentation/resource/value_manager.dart';




class onboardingView extends StatefulWidget {
  const onboardingView({super.key});

  @override
  State<onboardingView> createState() => _onboardingViewState();
}

class _onboardingViewState extends State<onboardingView> {
  final PageController _pageController = PageController(initialPage: 0);
final  OnboardingViewmodel _viewmodel = OnboardingViewmodel();

  _bind() {
    _viewmodel.start();
  }


  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
        stream: _viewmodel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SlideViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s1_5,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numOfSliders,
        onPageChanged: (int indexPage) {
          _viewmodel.onPageChanged(indexPage);
        },
        itemBuilder: ( context,  index) {
          return OnBoardingPage(sliderObject: sliderViewObject!.sliderObject);

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
           Expanded(child:  _getBottomSheetWidget(sliderViewObject)),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(SlideViewObject? sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
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
                _viewmodel.goPrevious() ;
              },
            ),

          ),

          Row(
            children: List.generate(sliderViewObject!.numOfSliders, (int i) {
              return Padding(
                padding: EdgeInsets.all(AppPadding.p8),
                child: _getProperCicrle(i, sliderViewObject.currentIndex),
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
               _viewmodel.goNext();
              },
            ),
          )
        ],
      ),
    );
  }


  Widget _getProperCicrle(int indexPage, int _currentIndex) {
    if (_currentIndex == indexPage) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else
      return SvgPicture.asset(ImageAssets.solidCircleIc);
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
            style: Theme
                .of(context)
                .textTheme
                .headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
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
