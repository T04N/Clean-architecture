import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvvm/app/extension.dart';
import 'package:nvvm/presentation/common/state_render/state_renderer.dart';
import 'package:nvvm/presentation/resource/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunc: retryActionFunction);
          }
        }
      case ErrorState:
        {
          dimissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            //Show PopUp dialog
            showPopUp(context, getStateRendererType(), getMessage());
            //return  content UI of the screen
            return contentScreenWidget;
          }
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunc: retryActionFunction,
          );

        }

      case EmptyState:
        dimissDialog(context);
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          retryActionFunc: retryActionFunction,
        );
      case ContentState:
        return contentScreenWidget;
      default:
        return contentScreenWidget;
    }
  }
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}



// dùng để kiểm tra xem một hộp thoại (Dialog) có đang hiển thị hay không.
_isThereCurrentDialoShowing(BuildContext context) =>
ModalRoute.of(context)?.isCurrent != true;

dimissDialog(BuildContext context ) {
  if (_isThereCurrentDialoShowing(context)) {
    Navigator.of(context, rootNavigator:true).pop(true);
  }
}

showPopUp(
    BuildContext context, StateRendererType stateRenderType, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
      context: context,
      builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRenderType,
            message: message,
            retryActionFunc: () {},
          )));
}
