import 'package:dartz/dartz.dart';

import '../../app/functions.dart';
import '../../data/request/request.dart';
import '../model/model.dart';
import '../responsitory/repository.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        input.username, input.password, "dummyImie", deviceInfo.nameDevice));
  }
}

class LoginUseCaseInput {
  String username;
  String password;

  LoginUseCaseInput(this.username, this.password);
}


