import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nvvm/app/app_prefs.dart';
import 'package:nvvm/app/dependency_inject.dart';
import 'package:nvvm/presentation/resource/asset_manager.dart';
import 'package:nvvm/presentation/resource/strings_manager.dart';
import 'package:nvvm/presentation/resource/value_manager.dart';

import '../common/state_render/state_renderer_imp.dart';
import '../resource/route_manager.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AppPreferences _appPreferences = getIt<AppPreferences>();
  LoginViewModel _viewModel = getIt<LoginViewModel>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _viewModel.isUserLoginSuccess.stream.listen((isLoggedSuccess) {
        print("isLoggedSuccess: $isLoggedSuccess"); // Thêm log tại đây để debug
      SchedulerBinding.instance?.addPostFrameCallback((_)  {
        _appPreferences.setIsUserLoggedIn();
      Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });

    });

    _usernameController
        .addListener(() => _viewModel.setUsername(_usernameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void dispose() {
    _viewModel.isUserLoginSuccess.close(); // Đóng stream khi không cần dùng nữa
    _usernameController.dispose(); // Đảm bảo đóng controller cho input
    _passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: AppPadding.p100),
          color: Colors.white,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    ImageAssets.splashLogo, // Adjust size as needed
                  ),
                  const SizedBox(height: AppSize.s28),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p20, right: AppPadding.p20),
                    child: StreamBuilder(
                        stream: _viewModel.outputUsernameValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: snapshot.hasData && !snapshot.data!
                                  ? AppStrings.usernameError
                                  : null,
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: AppSize.s28),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p20, right: AppPadding.p20),
                    child: StreamBuilder(
                        stream: _viewModel.outputPasswordValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: AppStrings.password,
                              labelText: AppStrings.password,
                              errorText: snapshot.hasData && !snapshot.data!
                                  ? AppStrings.passwordError
                                  : null,
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: AppSize.s28),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p20, right: AppPadding.p20),
                    child: StreamBuilder(
                        stream: _viewModel.outputAllValid,
                        builder: (context, snapdata) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: (snapdata.hasData && snapdata.data!)
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          _viewModel.login();
                                        }
                                      }
                                    : null,
                                child: Text(AppStrings.login)),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p20,
                        right: AppPadding.p20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.forgotPassRoute);
                            },
                            child: Text(AppStrings.forgetPassword)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.forgotPassRoute);
                            },
                            child: Text(AppStrings.registerText)),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.login();
                }) ??
                _getContentWidget();
          }),
    );
  }
}
