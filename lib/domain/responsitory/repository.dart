import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/data/responses/responses.dart';
import 'package:dartz/dartz.dart';

import '../../domain/model/model.dart';


abstract class Repository {
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}




