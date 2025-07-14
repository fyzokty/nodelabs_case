import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageClient {
  late final FlutterSecureStorage _secureStorage;

  StorageClient() : _secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }
}
