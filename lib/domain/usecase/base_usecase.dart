import 'package:dartz/dartz.dart';
import 'package:nvvm/domain/model/model.dart';

abstract class BaseUseCase<In, Out > {
  Future<Either<Failure,Out>> execute (In input);
}