import 'package:travel_guide_app/features/auth/domain/entities/user_entity.dart';
import 'package:travel_guide_app/features/auth/domain/repository/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepository;
  SignupUsecase({required this.authRepository});

  Future<UserEntity> call(String email, String password) {
    return authRepository.signup(email, password);
  }
}
