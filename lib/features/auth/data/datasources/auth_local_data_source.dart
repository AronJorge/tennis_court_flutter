import 'package:nolatech_tenis/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> login(String email, String password);

  Future<UserModel> register(UserModel userModel, String password);
}
