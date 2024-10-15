import 'package:dio/dio.dart';
import 'package:nvvm/data/network/app_api.dart';
import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationsResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(ForgotPassRequest forgotPassRequest);
}

class RemoteDataSourceImlements implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImlements(this._appServiceClient);

  @override
  Future<AuthenticationsResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email,
        loginRequest.password, loginRequest.imei, loginRequest.deviceType);
  }
  Future<ForgotPasswordResponse> forgotPassword(ForgotPassRequest request) async {
    try {
      final response = await _appServiceClient.forgotPassword(request.emailForgot);
      return response;
    } catch (e) {
      if (e is DioError) {
        print("DioError occurred: ${e.response?.data}");
      }
      throw e;  // Rethrow để xử lý ở lớp trên
    }
  }

}

