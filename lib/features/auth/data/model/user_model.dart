import '../../../../shared/entity/user.dart';

class UserModel extends User {
  UserModel({super.token, required super.name, required super.email, super.photoUrl, required super.id});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] != null ? map['token'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
    );
  }

  UserModel copyWith({String? token, String? id, String? name, String? email, String? photoUrl}) {
    return UserModel(
      token: token ?? this.token,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
