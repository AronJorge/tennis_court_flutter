import 'package:nolatech_tenis/features/auth/domain/repositories/auth_repository.dart';
import 'package:nolatech_tenis/features/common/domain/entities/user_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return repository.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }
}