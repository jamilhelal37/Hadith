// advanced_search_repository.dart
import 'package:dio/dio.dart';
import 'package:untitled1/model/advanced_search_model.dart';

class AdvancedSearchRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          'https://apibykassem.onrender.com', // Replace with your API base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<AdvancedSearchResponse> advancedSearch(
    AdvancedSearchRequest request,
  ) async {
    try {
      final response = await _dio.get(
        '/api/advanced_search', // Adjust endpoint as needed
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AdvancedSearchResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load search results');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Server error: ${e.response!.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
