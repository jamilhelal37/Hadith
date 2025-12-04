import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:untitled1/controller/search_cubit/search_state.dart';
import '../../model/search_model.dart';

class HadithCubit extends Cubit<HadithState> {
  final Dio dio;

  HadithCubit({required this.dio}) : super(HadithInitial());

  Future<void> searchHadith(String query) async {
    if (query.isEmpty) {
      emit(HadithInitial());
      return;
    }

    emit(HadithLoading());

    try {
      final response = await dio.get(
        '/api/search',
        queryParameters: {'query': query},
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final hadithModel = _parseResponse(response.data);
          emit(HadithSuccess(hadithModel));
        } catch (e) {
          emit(HadithError('Failed to parse API response: $e'));
        }
      } else if (response.statusCode == 404) {
        emit(HadithError('API endpoint not found (404)'));
      } else if (response.statusCode == 400) {
        emit(HadithError('Bad request. Please check your search query.'));
      } else {
        emit(HadithError('API returned status: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');

      if (e.response != null) {
        print('Error Response Status: ${e.response?.statusCode}');
        print('Error Response Data: ${e.response?.data}');
      }

      if (e.response?.statusCode == 404) {
        emit(HadithError('API endpoint not found (404)'));
      } else if (e.type == DioExceptionType.connectionTimeout) {
        emit(HadithError('Connection timeout. Please try again.'));
      } else if (e.type == DioExceptionType.unknown) {
        emit(HadithError('No internet connection or server is down.'));
      } else {
        emit(HadithError('Network error: ${e.message}'));
      }
    } catch (e) {
      print('Unexpected Error: $e');
      emit(HadithError('An unexpected error occurred: $e'));
    }
  }

  HadithModel _parseResponse(dynamic responseData) {
    try {
      // If the API returns with a 'data' field (matches our model)
      if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
        return HadithModel.fromJson(responseData);
      }
      // If the API returns the data directly as a list
      else if (responseData is List) {
        return HadithModel(
          data: responseData.map((item) {
            try {
              return Hadith.fromJson(item);
            } catch (e) {
              print('Error parsing individual hadith: $e');
              // Return a default/empty Hadith object for failed items
              return Hadith();
            }
          }).toList(),
        );
      }
      else {
        throw FormatException('Unexpected response format: $responseData');
      }
    } catch (e) {
      print('Parsing error: $e');
      rethrow;
    }
  }
  void clearSearch() {
    emit(HadithInitial());
  }
}