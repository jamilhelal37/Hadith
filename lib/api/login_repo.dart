import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<bool> login(LoginModel model) async {
    try {
      final response = await _dio.post(
        'https://apibykassem.onrender.com/api/login',
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

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
}
