import 'package:dio/dio.dart';

import '../model/book_model.dart';

class BookRepository{
  final Dio _dio;

  // You can customize Dio instance based on your needs
  BookRepository({Dio? dio})
      : _dio = dio ??
      Dio(BaseOptions(
        baseUrl: 'https://apibykassem.onrender.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ));
  Future<List<BookModel>> getAllBooks() async {
    try {
      final response = await _dio.get('/api/books');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load scholars: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to load scholars: $e');
    }
  }

  // Get single scholar by ID
  Future<BookModel> getBookById(int id) async {
    try {
      final response = await _dio.get('/api/books/$id');

      if (response.statusCode == 200) {
        return BookModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load scholar: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to load scholar: $e');
    }
  }


  // Error handler for Dio exceptions
  String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    } else if (e.type == DioExceptionType.sendTimeout) {
      return 'Send timeout';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'Connection error';
    } else if (e.type == DioExceptionType.cancel) {
      return 'Request cancelled';
    } else {
      return 'Network error: ${e.message}';
    }
  }

  // You can also add interceptors if needed
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
