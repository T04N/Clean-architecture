import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:nvvm/app/extension.dart';
import 'package:nvvm/domain/model/model.dart';
import 'package:nvvm/presentation/resource/asset_manager.dart';
import 'package:nvvm/presentation/resource/color_manager.dart';
import 'package:nvvm/presentation/resource/font_manager.dart';
import 'package:nvvm/presentation/resource/strings_manager.dart';
import 'package:nvvm/presentation/resource/value_manager.dart';

enum StateRendererType {
  // POPUPS STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final Failure? failure;
  final String message;
  final String title;
  final Function? retryActionFunc;

  const StateRenderer({
    Key? key,
    required this.stateRendererType,
    this.failure,
    String? message,
    String? title,
    this.retryActionFunc,
  })  : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Nếu failure là null, khởi tạo DefaultFailure tại đây
    final effectiveFailure = failure ?? DefaultFailure();
    return _getStateWidget(context); // Thay thế bằng UI thực tế
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopupDialog(context,[_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopupDialog(context,[_getAnimatedImage(JsonAssets.error), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemColumnn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(failure!.message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemColumnn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(failure!.message),
          _retryButton(context, AppStrings.retry_again)
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemColumnn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(failure!.message)]);
      default:
        return Container(); // Trường hợp không khớp sẽ trả về một widget rỗng
    }
  }


  Widget _getPopupDialog(BuildContext context,  List<Widget> childrenWidget ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s4),
      ),
      elevation: AppSize.s4,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: AppSize.s12,
              offset: Offset(AppSize.s0, AppSize.s12), // Sửa lại offset ở đây
            ),
          ],
        ),
        child: _getDialogContent(context, childrenWidget ),
      ),
    );
  }

 Widget _getDialogContent(BuildContext context, List<Widget> childrenWidget) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: childrenWidget,
    );

 }
  Widget _getAnimatedImage(String jsonImage) {
    return SizedBox(
      width: AppSize.s100,
      height: AppSize.s100,
      child: Lottie.asset(jsonImage),
    ); // jsonimgae)
  }

  Widget _getMessage(String message) {
    return Text(
      message,
      style: getMediumStyle(color: Colors.black, fontSize: FontSize.s16),
    ); // jsonimgae)
  }

  Widget _retryButton(BuildContext context,String buttonTitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s100,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryActionFunc?.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getItemColumnn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
