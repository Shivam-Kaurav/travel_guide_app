import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:travel_guide_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:travel_guide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:travel_guide_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_remote_data_source/destinations_remote_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_write_data_source.dart/destination_write_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/repository/destinations_repo_impl.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/get_destinations.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/get_destination_by_id.dart';
import 'package:travel_guide_app/features/destinations/presentation/bloc/destinations_bloc.dart';
import 'package:travel_guide_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Auth DI
  final firebaseAuth = FirebaseAuth.instance;
  final authRemoteDataSource = AuthRemoteDataSourceImpl(firebaseAuth);
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: authRemoteDataSource,
  );

  //Destinations DI
  final firestore = FirebaseFirestore.instance;
  final remoteDataSource = DestinationsRemoteDataSourceImpl(firestore);
  final writeDataSource = DestinationWriteDataSourceImpl(firestore);

  final repository = DestinationsRepositoryImpl(
    writeDataSource,
    remoteDataSource,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DestinationsBloc>(
          create: (_) => DestinationsBloc(
            GetDestinations(repository),
            GetDestinationById(repository),
          )..add(FetchDestinations()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            LoginUsecase(authRepository: authRepository),
            SignupUsecase(authRepository: authRepository),
            LogoutUsecase(authRepository: authRepository),
            authRepository,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SignUpPage(),
    );
  }
}
