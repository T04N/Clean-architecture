import 'package:dartz/dartz.dart';
import 'package:nvvm/data/data_source/remote_data_source.dart';
import 'package:nvvm/data/mapper/mapper.dart';
import 'package:nvvm/data/network/network_info.dart';
import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/data/responsitory/repository.dart';
import 'package:nvvm/presentation/domain/model.dart';

class RepositoryIml extends Repository {
  RepositoryIml(this._remoteDataSource, this._networkInfo);

  NetworkInfo _networkInfo;
  RemoteDataSource _remoteDataSource;


  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.login(loginRequest);

      if (response.baseResponseStatus == 0) {
        //  return data (Success )
        return Right(response.toAuthenticationDomain());
      }
      else {
        // return biz logiz error
        //return left
        return Left(Failure(
            409, response.message ?? "We have bit error logic from Api side"));
      }
    } else {
      return Left(Failure(501, "Plz check your internet"));
    }
    }
  }