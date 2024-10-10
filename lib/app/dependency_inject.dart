import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nvvm/data/data_source/remote_data_source.dart';
import 'package:nvvm/data/network/app_api.dart';
import 'package:nvvm/data/network/dio_factory.dart';
import 'package:nvvm/data/network/network_info.dart';
import 'package:nvvm/domain/responsitory/repository.dart';
import 'package:nvvm/domain/responsitory/repository_iml.dart';
import 'package:nvvm/domain/usecase/login_usecase.dart';
import 'package:nvvm/presentation/login/login_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  //NETWORK INFOR singleTon này regis chỉ 1 cái
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnection()));
//DIO FACTORY
  getIt.registerLazySingleton<DioFactory>(() => DioFactory());


// APP SERVICE CLINET
  final dio = await getIt<DioFactory>().getDio() ;


  //REMOTE DATA SOURCE
  getIt.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // REPOSITORY
  getIt.registerLazySingleton<Repository>(() => RepositoryIml(getIt(), getIt()));

  //
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImlements(getIt()));
}


initLoginModule()  {

  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    getIt.registerLazySingleton<LoginUsecase>(
            () => LoginUsecase(getIt())
    );
    getIt.registerLazySingleton<LoginViewModel>(
            () => LoginViewModel(getIt())
    );

  }



}
