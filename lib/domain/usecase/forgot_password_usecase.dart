import 'package:dartz/dartz.dart';
import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/domain/model/model.dart';
import 'package:nvvm/domain/responsitory/repository.dart';
import 'package:nvvm/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String emailforgot) async {
    return await _repository.forgotPassword(emailforgot);

  }
}
