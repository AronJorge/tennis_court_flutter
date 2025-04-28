import 'package:nolatech_tenis/features/auth/domain/repositories/auth_repository.dart';
import 'package:nolatech_tenis/features/common/domain/entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
