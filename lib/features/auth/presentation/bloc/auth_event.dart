part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  SignupRequested({required this.email, required this.password});
}

class LogoutRequested extends AuthEvent {}

class AuthStatusChanged extends AuthEvent {
  final UserEntity? user;
  AuthStatusChanged({this.user});
}
