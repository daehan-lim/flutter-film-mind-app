import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseTmdbDataSource {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      validateStatus: (status) => true,
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 6),
      headers: {
        'Authorization': "Bearer ${dotenv.env['TMDB_BEARER_TOKEN']}",
        'accept': 'application/json',
      },
    ),
  );

  Dio get dio => _dio;

  String? get bearerToken => dotenv.env['TMDB_BEARER_TOKEN'];
}