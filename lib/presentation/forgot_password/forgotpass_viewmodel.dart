import 'dart:async';

import 'package:nvvm/presentation/base/baseviewmodel.dart';
import 'package:nvvm/presentation/common/state_render/state_renderer.dart';
import 'package:nvvm/presentation/common/state_render/state_renderer_imp.dart';

import '../../domain/usecase/forgot_password_usecase.dart';

abstract class FPViewModelInput {
  void setEmailForgot(String email);
  void submitForgot();

  Sink get inputEmailForgot;
}

abstract class FPViewModelOutput {
  Stream<bool> get outputEmailValid;
}

class ForgotpassViewmodel extends BaseViewmodel
    implements FPViewModelInput, FPViewModelOutput {
  StreamController _inputEmailStream =
  StreamController<String>.broadcast();



  String emailForgot ="";

  ForgotpassViewmodel(this._forgotPasswordUseCase);
  ForgotPasswordUseCase _forgotPasswordUseCase;

  @override
  void start() {
    inputState.add(ContentState());
    super.start();
  }

  @override
  void dispose() {
    super.dispose();
    _inputEmailStream.close();
  }

  @override
  Sink get inputEmailForgot => _inputEmailStream.sink;

  @override
  Stream<bool> get outputEmailValid =>
      _inputEmailStream.stream.map((email) => _validateEmail(email));

  @override
  void setEmailForgot(String email) {
    inputEmailForgot.add(email);
    emailForgot = email;
  }

  @override
  void submitForgot() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase.execute(emailForgot)).fold((failure) {
      print(failure.message) ;
      inputState.add(
          ErrorState(message : failure.message, stateRendererType: StateRendererType.POPUP_ERROR_STATE));
    }, (supportMessage) {
      print("thanh cong ") ;
      inputState.add(
          SuccessState(message : supportMessage.support, stateRendererType: StateRendererType.POPUP_SUCCESS_STATE));
    });
  }
}

bool _validateEmail(String email) {
  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(emailPattern);
  return regex.hasMatch(email);
}
