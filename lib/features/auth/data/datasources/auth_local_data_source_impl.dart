import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nolatech_tenis/core/constants/local_data_source_keys.dart';
import 'package:nolatech_tenis/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:nolatech_tenis/features/auth/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UserModel?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(LocalDataSourceKeys.usersList);

    if (usersJson != null) {
      final usersList = List<Map<String, dynamic>>.from(jsonDecode(usersJson));
      final user = usersList.firstWhere(
        (user) => user['email'] == email,
        orElse: () => {},
      );

      if (user.isNotEmpty &&
          prefs.getString('${user['id']}_password') == password) {
        return UserModel.fromJson(user);
      }
    }

    return null;
  }

  @override
  Future<UserModel> register(UserModel userModel, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(LocalDataSourceKeys.usersList);
    final usersList =
        usersJson != null
            ? List<Map<String, dynamic>>.from(jsonDecode(usersJson))
            : <Map<String, dynamic>>[];

    usersList.add(userModel.toJson());

    await prefs.setString(LocalDataSourceKeys.usersList, jsonEncode(usersList));
    await prefs.setString('${userModel.id}_password', password);

    return userModel;
  }
}
