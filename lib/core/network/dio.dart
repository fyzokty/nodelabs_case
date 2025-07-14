import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class DioClient {
  late final Dio _dio;

  DioClient()
    : _dio = Dio(
          BaseOptions(
            sendTimeout: Duration(seconds: 15),
            receiveTimeout: Duration(seconds: 15),
            contentType: Headers.formUrlEncodedContentType,
          ),
        )
        ..interceptors.add(
          TalkerDioLogger(
            settings: const TalkerDioLoggerSettings(printResponseHeaders: true, printRequestHeaders: true),
          ),
        );

  Future<Response> get(Uri uri, [Options? options]) async {
    try {
      final res = _dio.getUri(uri, options: options);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(Uri uri, {Object? data, Options? options}) async {
    try {
      final res = _dio.postUri(uri, data: data, options: options);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
