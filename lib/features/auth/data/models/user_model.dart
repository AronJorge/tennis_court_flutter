import 'package:nolatech_tenis/core/constants/fields_contants.dart';
import 'package:nolatech_tenis/features/common/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[UserFields.id],
      name: json[UserFields.name],
      email: json[UserFields.email],
      phone: json[UserFields.phone],
    );
  }

  Map<String, dynamic> toJson() => {
    UserFields.id: id,
    UserFields.name: name,
    UserFields.email: email,
    UserFields.phone: phone,
  };
}
