import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:nolatech_tenis/core/init/initial_data.dart';

// Auth Feature
import 'package:nolatech_tenis/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:nolatech_tenis/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:nolatech_tenis/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nolatech_tenis/features/auth/domain/repositories/auth_repository.dart';
import 'package:nolatech_tenis/features/auth/domain/usecases/login_usecase.dart';
import 'package:nolatech_tenis/features/auth/domain/usecases/register_usecase.dart';
import 'package:nolatech_tenis/features/auth/presentation/bloc/auth_bloc.dart';

// Court Feature
import 'package:nolatech_tenis/features/court/data/datasources/court_local_data_source.dart';
import 'package:nolatech_tenis/features/court/data/datasources/court_local_data_source_impl.dart';
import 'package:nolatech_tenis/features/court/data/repositories/court_repository_impl.dart';
import 'package:nolatech_tenis/features/court/domain/repositories/court_repository.dart';
import 'package:nolatech_tenis/features/court/domain/usecases/list_courts_usecase.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_bloc.dart';

// Reservation Feature
import 'package:nolatech_tenis/features/reservation/data/datasources/reservation_local_data_source.dart';
import 'package:nolatech_tenis/features/reservation/data/repositories/reservation_repository_impl.dart';
import 'package:nolatech_tenis/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/list_reservations_usecase.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/mark_favorite_usecase.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_bloc.dart';

// Weather Feature
import 'package:nolatech_tenis/features/court/data/datasources/weather_remote_data_source.dart';
import 'package:nolatech_tenis/features/court/data/repositories/weather_repository_impl.dart';
import 'package:nolatech_tenis/features/court/domain/repositories/weather_repository.dart';
import 'package:nolatech_tenis/features/court/domain/usecases/get_rain_probability_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await InitialDataSeeder.seedAll();

  // External
  sl.registerLazySingleton(() => Dio());

  // Blocs
  sl.registerFactory(() => AuthBloc(loginUseCase: sl(), registerUseCase: sl()));
  sl.registerFactory(
    () => CourtBloc(listCourtsUseCase: sl(), getRainProbabilityUseCase: sl()),
  );
  sl.registerFactory(
    () => ReservationBloc(
      createReservationUseCase: sl(),
      listReservationsUseCase: sl(),
      deleteReservationUseCase: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ListCourtsUseCase(sl()));
  sl.registerLazySingleton(() => CreateReservationUseCase(sl()));
  sl.registerLazySingleton(() => DeleteReservationUseCase(sl()));
  sl.registerLazySingleton(() => ListReservationsUseCase(sl()));
  sl.registerLazySingleton(() => MarkFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetRainProbabilityUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CourtRepository>(
    () => CourtRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl()),
  );

  // DataSources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<CourtLocalDataSource>(
    () => CourtLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ReservationLocalDataSource>(
    () => ReservationLocalDataSource(),
  );
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSource(sl()),
  );

}
