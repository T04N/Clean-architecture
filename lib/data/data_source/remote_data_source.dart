import 'package:nvvm/data/network/app_api.dart';
import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationsResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImlements implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImlements(this._appServiceClient);

  @override
  Future<AuthenticationsResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email,
        loginRequest.password, loginRequest.imei, loginRequest.deviceType);
  }
}
