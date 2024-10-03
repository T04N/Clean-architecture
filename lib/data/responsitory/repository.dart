import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/data/responses/responses.dart';
import 'package:nvvm/presentation/domain/model.dart';
import 'package:dartz/dartz.dart';


abstract class Repository {
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}




