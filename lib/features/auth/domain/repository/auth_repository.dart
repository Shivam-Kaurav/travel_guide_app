import 'package:travel_guide_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signup(String email, String password);
  Future<void> logout();
  Stream<UserEntity?> authStateChanges();
}
