import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_guide_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:travel_guide_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:travel_guide_app/features/auth/domain/repository/auth_repository.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:travel_guide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_remote_data_source/destinations_remote_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_write_data_source.dart/destination_write_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/repository/destinations_repo_impl.dart';
import 'package:travel_guide_app/features/destinations/domain/repository/destinations_repo.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/get_destination_by_id.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/get_destinations.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/seed_destinations.dart';
import 'package:travel_guide_app/features/destinations/presentation/bloc/destinations_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  ///External

  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  ///Auth Feature

  //Data sources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  //Repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()),
  );

  //use cases
  serviceLocator.registerLazySingleton(
    () => LoginUsecase(authRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => LogoutUsecase(authRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => SignupUsecase(authRepository: serviceLocator()),
  );

  //bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  ///Destinations Feature

  //Data sources
  serviceLocator.registerLazySingleton<DestinationsRemoteDataSource>(
    () => DestinationsRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DestinationWriteDataSource>(
    () => DestinationWriteDataSourceImpl(serviceLocator()),
  );

  //Repositories
  serviceLocator.registerLazySingleton<DestinationsRepository>(
    () => DestinationsRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  //use cases
  serviceLocator.registerLazySingleton(
    () => GetDestinationById(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => GetDestinations(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => SeedDestinations(serviceLocator()),
  );

  //bloc
  serviceLocator.registerFactory(
    () => DestinationsBloc(serviceLocator(), serviceLocator()),
  );
}
