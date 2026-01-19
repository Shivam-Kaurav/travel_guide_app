import 'package:travel_guide_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:travel_guide_app/features/auth/data/models/user_model.dart';
import 'package:travel_guide_app/features/auth/domain/entities/user_entity.dart';
import 'package:travel_guide_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Stream<UserEntity?> authStateChanges() {
    return authRemoteDataSource.authStateChanges().map(
      (user) => user == null ? null : UserModel.fromFirebaseUser(user),
    );
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    final firebaseUser = await authRemoteDataSource.login(email, password);
    return UserModel.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<void> logout() async {
    await authRemoteDataSource.logout();
  }

  @override
  Future<UserEntity> signup(String email, String password) async {
    final firebaseUser = await authRemoteDataSource.signup(email, password);
    return UserModel.fromFirebaseUser(firebaseUser);
  }
}
