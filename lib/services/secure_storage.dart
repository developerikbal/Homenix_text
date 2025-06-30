import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A class to manage secure storage operations like saving and reading user data,
/// developer access key, etc.
class SecureStorageManager {
  // Singleton instance
  static final SecureStorageManager _instance = SecureStorageManager._internal();
  factory SecureStorageManager() => _instance;
  SecureStorageManager._internal();

  // Instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Write data securely with a key-value pair
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read data securely by key
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a specific key-value pair securely
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete all stored secure data
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Check whether a key exists (value is not null)
  Future<bool> containsKey(String key) async {
    String? value = await _storage.read(key: key);
    return value != null;
  }

  /// Store user login token
  Future<void> saveUserToken(String token) async {
    await write("user_token", token);
  }

  /// Retrieve user login token
  Future<String?> getUserToken() async {
    return await read("user_token");
  }

  /// Save user email securely
  Future<void> saveUserEmail(String email) async {
    await write("user_email", email);
  }

  /// Retrieve stored user email
  Future<String?> getUserEmail() async {
    return await read("user_email");
  }

  /// Save developer access key (Only if matched)
  Future<void> saveDeveloperKey(String devKey) async {
    await write("developer_access_key", devKey);
  }

  /// Check if the current user has developer access
  Future<bool> isDeveloper() async {
    String? key = await read("developer_access_key");
    return key == "frontendwebdeveloperikbal@gmail.com";
  }
}
