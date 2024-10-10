import 'package:dartz/dartz.dart';
import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/domain/model/model.dart';

import '../../app/functions.dart';

import '../responsitory/repository.dart';
import 'base_usecase.dart';

class LoginUsecase extends BaseUseCase<LoginUsecaseInput, Authentication> {
  Repository _repository;

  LoginUsecase(this._repository);  // Thêm constructor để khởi tạo repository

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUsecaseInput input) async {
    try {
      // Lấy thông tin thiết bị
      DeviceInfo _deviceInfo = await getDeviceDeviceDetails();

      // Tạo request đăng nhập
      LoginRequest loginRequest = LoginRequest(
          input.username, input.password, "dummyImie", _deviceInfo.nameDevice);

      // Gọi đến repository để thực hiện đăng nhập
      Either<Failure, Authentication> result = await _repository.login(loginRequest);

      // Trả về kết quả từ repository (Either<Failure, Authentication>)
      return result;
    } catch (error) {
      // Xử lý lỗi và trả về đối tượng Failure
      return Left(Failure(error.hashCode, error.toString()));
    }
  }
}

class LoginUsecaseInput {
  String username;
  String password;
  LoginUsecaseInput(this.username, this.password);
}
