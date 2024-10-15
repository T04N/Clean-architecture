import 'dart:async';
import 'package:nvvm/domain/usecase/login_usecase.dart';
import 'package:nvvm/presentation/base/baseviewmodel.dart';
import 'package:nvvm/presentation/common/state_render/state_renderer.dart';
import 'package:nvvm/presentation/common/state_render/state_renderer_imp.dart';

import '../common/freezed_data_class.dart';

class LoginViewModel extends BaseViewmodel
    implements LoginViewModelInput, LoginViewModelOutput {
  LoginViewModel(this._loginUsecase);

  LoginUseCase _loginUsecase;

  StreamController<String> _inputUsernameController =
      StreamController<String>.broadcast();
  StreamController<String> _inputPasswordController =
      StreamController<String>.broadcast();

  StreamController _inputAllValidController =
      StreamController<void>.broadcast();

  StreamController isUserLoginSuccess = StreamController<bool>();

  var loginObject = LoginObject(username: '', password: '');

  @override
  void start() {
    //view  tell state render, plz show content of the screen
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _inputUsernameController.close();
    _inputPasswordController.close();
    _inputAllValidController.close();
    isUserLoginSuccess.close();
  }

  @override
  Sink get inputPassword => _inputPasswordController.sink;

  @override
  Sink get inputUsername => _inputUsernameController.sink;

  @override
  Sink get inputAll => _inputAllValidController.sink;



  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUsecase.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold(
            (failure) => {
                  // left -> failure
                  inputState.add(ErrorState(
                      stateRendererType: StateRendererType.POPUP_ERROR_STATE,
                      message: failure.message))
                }, (data) {
      // right -> success (data)
      inputState.add(ContentState());
      isUserLoginSuccess.add(true); //NAVIGATOR TO MAIN SCREEN
      print(
          "Login success, navigating to main screen"); // Thêm log tại đây để kiểm tra
    });
  }

  @override
  Stream<bool> get outputPasswordValid {
    // Cung cấp stream kiểm tra tính hợp lệ của password
    return _inputPasswordController.stream
        .map((password) => _isValidPassword(password));
  }

  @override
  Stream<bool> get outputUsernameValid {
    // Cung cấp stream kiểm tra tính hợp lệ của username
    return _inputUsernameController.stream
        .map((username) => _isValidUsername(username));
  }

  @override
  Stream<bool> get outputAllValid =>
      _inputAllValidController.stream.map((valid) => _isValidAll());

  void setPassword(String password) {
    _inputPasswordController.sink.add(password);
    loginObject = loginObject.copyWith(password: password);
    _inputAllValidController.sink.add(null);
  }

  void setUsername(String username) {
    _inputUsernameController.sink.add(username);
    loginObject = loginObject.copyWith(username: username);
    _inputAllValidController.sink.add(null);
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty;
  }

  bool _isValidUsername(String username) {
    return username.isNotEmpty;
  }

  bool _isValidAll() {
    return _isValidUsername(loginObject.username) &&
        _isValidPassword(loginObject.password);
  }
}

abstract class LoginViewModelInput {
  // was changed

  void setUsername(String username);

  void setPassword(String password);

  void login();

  Sink get inputUsername;

  Sink get inputPassword;

  Sink get inputAll;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputUsernameValid;

  Stream<bool> get outputPasswordValid;

  Stream<bool> get outputAllValid;
}
