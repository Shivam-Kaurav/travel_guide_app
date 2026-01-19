import 'package:travel_guide_app/features/auth/domain/repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;
  LogoutUsecase({required this.authRepository});

  Future<void> call() {
    return authRepository.logout();
  }
}
