import 'package:get/get.dart';
import 'package:chargerrr/data/repositories/auth_repository_impl.dart';
import 'package:chargerrr/data/repositories/station_repository_impl.dart';
import 'package:chargerrr/data/datasources/remote/supabase_auth_datasource.dart';
import 'package:chargerrr/data/datasources/remote/supabase_station_datasource.dart';
import 'package:chargerrr/domain/repositories/auth_repository.dart';
import 'package:chargerrr/domain/repositories/station_repository.dart';
import 'package:chargerrr/domain/usecases/auth/login_usecase.dart';
import 'package:chargerrr/domain/usecases/auth/register_usecase.dart';
import 'package:chargerrr/domain/usecases/auth/logout_usecase.dart';
import 'package:chargerrr/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:chargerrr/domain/usecases/station/get_stations_usecase.dart';
import 'package:chargerrr/domain/usecases/station/get_station_details_usecase.dart';
import 'package:chargerrr/domain/usecases/station/create_station_usecase.dart';

Future<void> initDependencies() async {
  // Data Sources
  Get.lazyPut<SupabaseAuthDataSource>(
    () => SupabaseAuthDataSourceImpl(),
    fenix: true,
  );
  
  Get.lazyPut<SupabaseStationDataSource>(
    () => SupabaseStationDataSourceImpl(),
    fenix: true,
  );
  
  // Repositories
  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(Get.find<SupabaseAuthDataSource>()),
    fenix: true,
  );
  
  Get.lazyPut<StationRepository>(
    () => StationRepositoryImpl(Get.find<SupabaseStationDataSource>()),
    fenix: true,
  );
  
  // Use Cases - Auth
  Get.lazyPut<LoginUseCase>(
    () => LoginUseCase(Get.find<AuthRepository>()),
    fenix: true,
  );
  
  Get.lazyPut<RegisterUseCase>(
    () => RegisterUseCase(Get.find<AuthRepository>()),
    fenix: true,
  );
  
  Get.lazyPut<LogoutUseCase>(
    () => LogoutUseCase(Get.find<AuthRepository>()),
    fenix: true,
  );
  
  Get.lazyPut<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(Get.find<AuthRepository>()),
    fenix: true,
  );
  
  // Use Cases - Station
  Get.lazyPut<GetStationsUseCase>(
    () => GetStationsUseCase(Get.find<StationRepository>()),
    fenix: true,
  );
  
  Get.lazyPut<GetStationDetailsUseCase>(
    () => GetStationDetailsUseCase(Get.find<StationRepository>()),
    fenix: true,
  );
  
  Get.lazyPut<CreateStationUseCase>(
    () => CreateStationUseCase(Get.find<StationRepository>()),
    fenix: true,
  );
}