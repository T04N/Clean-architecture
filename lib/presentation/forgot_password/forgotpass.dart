import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvvm/presentation/common/state_render/state_renderer_imp.dart';

import '../../app/dependency_inject.dart';
import '../resource/asset_manager.dart';
import '../resource/strings_manager.dart';
import '../resource/value_manager.dart';
import 'forgotpass_viewmodel.dart';

class ForgotpassView extends StatefulWidget {
  const ForgotpassView({super.key});

  @override
  State<ForgotpassView> createState() => _ForgotpassViewState();
}

class _ForgotpassViewState extends State<ForgotpassView> {
  final _formKey = GlobalKey<FormState>();
  ForgotpassViewmodel _viewModel = getIt<ForgotpassViewmodel>();
  TextEditingController _emailController = TextEditingController();

  bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,  // Lắng nghe các trạng thái từ ViewModel
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Chuyển đổi giao diện dựa trên trạng thái hiện tại
            return snapshot.data!.getScreenWidget(
              context,
              _getContentWidget(),
                  () => _viewModel.submitForgot(),  // Retry action khi gặp lỗi
            );
          } else {
            return _getContentWidget();
          }
        },
      ),
    );
  }


  Widget _getContentWidget() {
    return Container(
      child: SingleChildScrollView(
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
                        stream: _viewModel.outputEmailValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: AppStrings.forgetPassword,
                              labelText: AppStrings.forgetPassword,
                              errorText: snapshot.hasData && !snapshot.data!
                                  ? AppStrings.usernameError
                                  : null,
                            ),
                            onChanged: (email) {
                              _viewModel.setEmailForgot(email);
                            },
                          );
                        }),
                  ),
                  SizedBox(
                    height: AppPadding.p20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p20, right: AppPadding.p20),
                    child: StreamBuilder(
                        stream: _viewModel.outputEmailValid,
                        builder: (context, snapdata) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: (snapdata.hasData && snapdata.data!)
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          _viewModel.submitForgot();
                                        }
                                      }
                                    : null,
                                child: Text("Reset password")),
                          );
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
