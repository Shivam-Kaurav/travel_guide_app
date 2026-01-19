import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travel_guide_app/features/auth/domain/entities/user_entity.dart';
import 'package:travel_guide_app/features/auth/domain/repository/auth_repository.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:travel_guide_app/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final LogoutUsecase logoutUsecase;
  final AuthRepository authRepository;
  late final StreamSubscription _authSubscription;
  AuthBloc(
    this.loginUsecase,
    this.signupUsecase,
    this.logoutUsecase,
    this.authRepository,
  ) : super(AuthInitial()) {
    _authSubscription = authRepository.authStateChanges().listen(
      (user) => add(AuthStatusChanged(user: user)),
    );

    on<LoginRequested>(_onLogin);
    on<SignupRequested>(_onSignup);
    on<LogoutRequested>(_onLogout);
    on<AuthStatusChanged>(_onAuthChanged);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUsecase(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignup(SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signupUsecase(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await logoutUsecase();
    emit(AuthUnauthenticated());
  }

  void _onAuthChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    if (event.user == null) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated(event.user!));
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
