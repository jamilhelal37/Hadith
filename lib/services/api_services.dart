import 'package:dio/dio.dart';
import 'package:untitled1/model/regester_model.dart';
import '../model/login_model.dart';

class ApiRepositry {
   static String endPoint='https://apibykassem.onrender.com/api';
  final Dio _dio = Dio();

  Future<bool> login(LoginModel model) async {
    try {
      final response = await _dio.post(
        '$endPoint/login',
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('auth_token', token);

        print('Token saved successfully!');
        return true;
      } else {
        print('Login failed: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }


    Future<bool> regester(RegesterModel model) async {
    try {
      final response = await _dio.post(
       '$endPoint/auth/register',
        data: model.toJson(),
       );
       if (response.statusCode.toString()[0]== '2') {
        final token = response.data['token'];

       // final prefs = await SharedPreferences.getInstance();
       //  await prefs.setString('auth_token', token);

        print('Token saved successfully!');
        return true;
      } else {
        print('Login failed: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      return false;
    } catch (e) {
      print('unexpected error: $e');
      return false;
    }
  }
}


// class HadithRepository {
//   final Dio _dio = Dio();
//
//   // Replace with your actual API endpoint
//   static const String endPoint = 'https://apibykassem.onrender.com/api';
//
//   Future<HadithModel> searchHadith(String query) async {
//     try {
//       final response = await _dio.get(
//         '$endPoint/search',
//         queryParameters: {'q': query},
//         options: Options(
//         //  headers: {'key': 'query'},
//           receiveTimeout: const Duration(seconds: 30),
//           sendTimeout: const Duration(seconds: 30),
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         return HadithModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load hadiths: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout ||
//           e.type == DioExceptionType.receiveTimeout ||
//           e.type == DioExceptionType.sendTimeout) {
//         throw Exception('Connection timeout. Please try again.');
//       } else if (e.type == DioExceptionType.connectionError) {
//         throw Exception('No internet connection.');
//       } else {
//         throw Exception('Failed to search hadiths: ${e.message}');
//       }
//     } catch (e) {
//       throw Exception('An error occurred: $e');
//     }
//   }
//
//   Future<HadithModel> getAllHadiths() async {
//     try {
//       final response = await _dio.get(
//         '$endPoint/search',
//         options: Options(
//           receiveTimeout: const Duration(seconds: 30),
//           sendTimeout: const Duration(seconds: 30),
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         return HadithModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load hadiths: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       throw Exception('Failed to load hadiths: ${e.message}');
//     } catch (e) {
//       throw Exception('An error occurred: $e');
//     }
//   }
//
// }