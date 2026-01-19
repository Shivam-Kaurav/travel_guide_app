import 'package:travel_guide_app/features/auth/domain/entities/user_entity.dart';
import 'package:travel_guide_app/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});

  Future<UserEntity> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
