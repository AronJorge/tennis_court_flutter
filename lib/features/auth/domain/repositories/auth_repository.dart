import 'package:nolatech_tenis/features/common/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});

  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
}
