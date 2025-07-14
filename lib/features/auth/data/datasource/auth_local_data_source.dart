import '../../../../core/local_storage/secure_storage.dart';

abstract interface class AuthLocalDataSource {
  Future<String?> readToken();
  Future<void> writeToken(String token);
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this.client);

  final StorageClient client;

  static const tokenKey = 'token';

  @override
  Future<void> deleteToken() async {
    await client.delete(tokenKey);
  }

  @override
  Future<String?> readToken() async {
    return await client.read(tokenKey);
  }

  @override
  Future<void> writeToken(String token) async {
    await client.write(key: tokenKey, value: token);
  }
}
