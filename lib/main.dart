import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:travel_guide_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:travel_guide_app/features/destinations/presentation/bloc/destinations_bloc.dart';
import 'package:travel_guide_app/firebase_options.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DestinationsBloc>(
          create: (_) =>
              di.serviceLocator<DestinationsBloc>()..add(FetchDestinations()),
        ),
        BlocProvider<AuthBloc>(create: (_) => di.serviceLocator<AuthBloc>()),
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
