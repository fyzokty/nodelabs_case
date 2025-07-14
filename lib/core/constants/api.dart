class ApiConst {
  const ApiConst._();

  static const apiURL = 'caseapi.servicelabs.tech';

  static Uri uri(String path, [Map<String, dynamic>? queryParameters]) =>
      Uri(scheme: 'https', host: apiURL, path: path, queryParameters: queryParameters);

  static final register = uri('/user/register');
  static final login = uri('/user/login');
  static final profile = uri('user/profile');
  static final uploadPhoto = uri('user/upload_photo');
}
