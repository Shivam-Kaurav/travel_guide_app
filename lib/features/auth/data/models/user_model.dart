import 'package:travel_guide_app/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({required super.uid, super.email});

  ///firebase user -> User Model
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(uid: user.uid, email: user.email);
  }

  ///Json to UserModel(Firestore/API)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
    );
  }
  //User Model to Json
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }
}
