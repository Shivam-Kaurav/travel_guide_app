import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide_app/core/di/injection_container.dart';
import 'package:travel_guide_app/core/notifications/notification_service.dart';
import 'package:travel_guide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:travel_guide_app/features/auth/presentation/pages/log_in_page.dart';
import 'package:travel_guide_app/features/auth/presentation/widgets/app_elevated_button.dart';
import 'package:travel_guide_app/features/auth/presentation/widgets/input_field.dart';
import 'package:travel_guide_app/features/destinations/presentation/pages/home_screen.dart';

class SignUpPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty || value.length < 6) {
      return 'Password must be atleast 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        final notificationService = serviceLocator<NotificationService>();
        if (state is AuthAuthenticated) {
          notificationService.show(
            title: 'Signup Successful',
            body: 'Your account has been created',
          );
          Navigator.push(context, HomeScreen.route());
        } else if (state is AuthError) {
          notificationService.show(title: 'Signup failed', body: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: Image.asset(
                        'assets/images/signup.png',
                        fit: BoxFit.cover,
                        cacheWidth: 1025,
                        cacheHeight: 683,
                      ),
                    ),
                    const SizedBox(height: 35),
                    InputField(
                      validator: _validateEmail,
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    InputField(
                      validator: _validatePassword,
                      hintText: 'password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 35),
                    AppElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  SignupRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                      label: 'Sign Up',
                    ),
                    const SizedBox(height: 35),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, LoginPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
