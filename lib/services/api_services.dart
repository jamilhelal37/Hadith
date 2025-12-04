import 'package:dio/dio.dart';
import 'package:untitled1/model/book_model.dart';
import 'package:untitled1/model/muhaddith_model.dart';
import 'package:untitled1/model/rawi_model.dart';
import 'package:untitled1/model/regester_model.dart';
import 'package:untitled1/model/ruling_model.dart';
import 'package:untitled1/model/subject_model.dart';
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
// lib/repositories/scholars_repository.dart

class MuhaddithRepository {
  final Dio _dio;

  // You can customize Dio instance based on your needs
  MuhaddithRepository({Dio? dio})
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

  // Get all scholars
  Future<List<MuhaddithModel>> getAllMuhadiths() async {
    try {
      final response = await _dio.get('/api/muhaddiths'); // Adjust endpoint

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => MuhaddithModel.fromJson(json)).toList();
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
  Future<MuhaddithModel> getMuhaddithById(int id) async {
    try {
      final response = await _dio.get('/api/muhaddiths/$id');

      if (response.statusCode == 200) {
        return MuhaddithModel.fromJson(response.data);
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

class RawisRepository{
  final Dio _dio;

  // You can customize Dio instance based on your needs
  RawisRepository({Dio? dio})
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
  Future<List<RawiModel>> getAllRawis() async {
    try {
      final response = await _dio.get('/api/rawis'); // Adjust endpoint

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => RawiModel.fromJson(json)).toList();
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
  Future<RawiModel> getRawiById(int id) async {
    try {
      final response = await _dio.get('/api/rawis/$id');

      if (response.statusCode == 200) {
        return RawiModel.fromJson(response.data);
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

class SubjectsRepository{
  final Dio _dio;

  // You can customize Dio instance based on your needs
  SubjectsRepository({Dio? dio})
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
  Future<List<SubjectModel>> getAllSubjects() async {
    try {
      final response = await _dio.get('/api/topics'); // Adjust endpoint

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => SubjectModel.fromJson(json)).toList();
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
  Future<SubjectModel> getSubjectById(int id) async {
    try {
      final response = await _dio.get('/api/topics/$id');

      if (response.statusCode == 200) {
        return SubjectModel.fromJson(response.data);
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

class RulingRepository{
  final Dio _dio;

  // You can customize Dio instance based on your needs
  RulingRepository({Dio? dio})
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
  Future<List<RulingModel>> getAllRuling() async {
    try {
      final response = await _dio.get('/api/ruling_of_hadiths');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => RulingModel.fromJson(json)).toList();
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
  Future<RulingModel> getRulingById(int id) async {
    try {
      final response = await _dio.get('/api/ruling_of_hadiths/$id');

      if (response.statusCode == 200) {
        return RulingModel.fromJson(response.data);
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