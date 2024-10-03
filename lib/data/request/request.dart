import 'package:nvvm/data/request/request.dart';

class LoginRequest {
  LoginRequest(this.email, this.password, this.imei, this.deviceType);

  String email;
  String password;
  String imei;
  String deviceType;
}
