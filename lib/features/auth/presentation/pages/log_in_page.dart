import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:travel_guide_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:travel_guide_app/features/auth/presentation/widgets/app_elevated_button.dart';
import 'package:travel_guide_app/features/auth/presentation/widgets/input_field.dart';
import 'package:travel_guide_app/features/destinations/presentation/pages/home_screen.dart';

class LoginPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LoginPage> {
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
        if (state is AuthAuthenticated) {
          Navigator.push(context, HomeScreen.route());
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
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
                        'assets/images/login.png',
                        fit: BoxFit.cover,
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
                                  LoginRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                      label: 'Log In',
                    ),
                    const SizedBox(height: 35),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignUpPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
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
