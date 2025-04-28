import 'package:hive/hive.dart';
import 'package:nolatech_tenis/core/constants/local_data_source_keys.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  final Box _userBox = Hive.box(LocalDataSourceKeys.userBox);

  Future<void> saveUser(Map<String, dynamic> user) async {
    final users = List<Map<String, dynamic>>.from(
      _userBox.get(LocalDataSourceKeys.usersList) ?? [],
    );

    users.add(user);
    await _userBox.put(LocalDataSourceKeys.usersList, users);
    await _userBox.put(LocalDataSourceKeys.currentUserId, user['id']);
  }

  List<Map<String, dynamic>> getUsers() {
    return List<Map<String, dynamic>>.from(
      _userBox.get(LocalDataSourceKeys.usersList) ?? [],
    );
  }

  Map<String, dynamic>? getCurrentUser() {
    final users = getUsers();
    final currentUserId = _userBox.get(LocalDataSourceKeys.currentUserId);
    return users.firstWhere(
          (user) => user['id'] == currentUserId,
      orElse: () => {},
    );
  }

  String getCurrentUserName() {
    final user = getCurrentUser();
    return user?['name'] ?? '';
  }

  Future<void> clearCurrentUser() async {
    await _userBox.delete(LocalDataSourceKeys.currentUserId);
  }

  Future<void> clearAllUsers() async {
    await _userBox.delete(LocalDataSourceKeys.usersList);
    await _userBox.delete(LocalDataSourceKeys.currentUserId);
  }
}

