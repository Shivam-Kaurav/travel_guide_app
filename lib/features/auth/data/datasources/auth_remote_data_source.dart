import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);
  Future<User> signup(String email, String password);
  Future<void> logout();
  Stream<User?> authStateChanges();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthRemoteDataSourceImpl(this._firebaseAuth);
  @override
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  @override
  Future<User> login(String email, String password) async {
    final credentials = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user!;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<User> signup(String email, String password) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user!;
  }
}
