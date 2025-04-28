import 'package:nolatech_tenis/core/constants/error_messages.dart';
import 'package:nolatech_tenis/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:nolatech_tenis/features/auth/data/models/user_model.dart';
import 'package:nolatech_tenis/features/auth/domain/repositories/auth_repository.dart';
import 'package:nolatech_tenis/features/common/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<UserEntity> login({required String email, required String password}) {
    return localDataSource.login(email, password).then((user) {
      if (user == null) {
        throw Exception(ErrorMessages.invalidCredentials);
      }
      return user;
    });
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
    );
    return localDataSource.register(newUser, password);
  }
}
