import 'package:dartz/dartz.dart';
import 'package:nvvm/data/data_source/remote_data_source.dart';
import 'package:nvvm/data/mapper/mapper.dart';
import 'package:nvvm/data/network/error_handler.dart';
import 'package:nvvm/data/network/network_info.dart';
import 'package:nvvm/data/request/request.dart';
import 'package:nvvm/domain/responsitory/repository.dart';

import '../../domain/model/model.dart';

class RepositoryIml extends Repository {
  RepositoryIml(this._remoteDataSource, this._networkInfo);

  NetworkInfo _networkInfo;
  RemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.login(loginRequest);

      if (response.baseResponseStatus == ApiInternalStatus.SUCCESS) {
        //  return data (Success )
        return Right(response.toAuthenticationDomain());
      } else {
        // return biz logic error
        return Left(Failure(
            409, response.message ?? "We have bit error logic from API side"));
      }
    } else {
      return Left(Failure(501, "Please check your internet"));
    }
  }

  @override
  Future<Either<Failure, Support>> forgotPassword(
      ForgotPassRequest forgotPassRequest) async {
    if (await _networkInfo.isConnected) {
      ForgotPassRequest MockMail =    ForgotPassRequest("tev@gmail.com");
      final response = await _remoteDataSource.forgotPassword(MockMail);
        print("RepositoryIml: Received response with status ${response.baseResponseStatus}");
      if (response.baseResponseStatus == ApiInternalStatus.SUCCESS) {
        return Right(response.toSupportDomain());
      } else {
        print("RepositoryIml: Forgot password failed with message: ${response.message}");
        return Left(Failure(
            409, response.message ?? "We have bit error logic from API side"));
      }
    } else {
      return Left(Failure(501, "Please check your internet"));
    }

    // Trả về mặc định nếu có lỗi logic
    return Left(Failure(500, "Unknown error occurred"));
  }

}
