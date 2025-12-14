// favorite_cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/favorite_hadith.dart';
class FavoriteCubit extends Cubit<FavoriteState> {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://apibykassem.onrender.com/api/favorites';

  FavoriteCubit() : super(FavoriteInitial()) {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  // Add hadith to favorites
  Future<void> addToFavorites(int hadithId) async {
    try {
      emit(FavoriteLoading());

      final response = await _dio.post(
        '/add',
        queryParameters: {'hadith_id': hadithId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(FavoriteAdded(hadithId: hadithId));
      } else {
        emit(FavoriteError(message: 'Failed to add to favorites'));
      }
    } on DioException catch (e) {
      emit(FavoriteError(
        message: e.response?.data?['message'] ?? 'Network error',
      ));
    } catch (e) {
      emit(FavoriteError(message: 'Unexpected error'));
    }
  }

  // Remove hadith from favorites
  Future<void> removeFromFavorites(int hadithId) async {
    try {
      emit(FavoriteLoading());

      final response = await _dio.post(
        '/remove',
        queryParameters: {'hadith_id': hadithId},
      );

      if (response.statusCode == 200||response.statusCode==201) {
        emit(FavoriteRemoved(hadithId: hadithId));
      } else {
        emit(FavoriteError(message: 'Failed to remove from favorites'));
      }
    } on DioException catch (e) {
      emit(FavoriteError(
        message: e.response?.data?['message'] ?? 'Network error',
      ));
    } catch (e) {
      emit(FavoriteError(message: 'Unexpected error'));
    }
  }

  // Check if a hadith is in favorites
  Future<bool> isFavorite(int hadithId) async {
    try {
      final response = await _dio.get('');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['data'] != null && data['data'] is List) {
          final favorites = data['data'] as List;
          return favorites.any((fav) => fav['hadith_id'] == hadithId);
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Get all favorites
  Future<void> getFavorites({int page = 1, int limit = 20}) async {
    try {
      emit(FavoriteLoading());

      final response = await _dio.get('', queryParameters: {
        'page': page,
        'limit': limit,
      });

      if (response.statusCode == 200) {
        final favoriteResponse = FavoriteResponse.fromJson(response.data);
        emit(FavoritesLoaded(favorites: favoriteResponse));
      } else {
        emit(FavoriteError(message: 'Failed to load favorites'));
      }
    } on DioException catch (e) {
      emit(FavoriteError(
        message: e.response?.data?['message'] ?? 'Network error',
      ));
    } catch (e) {
      emit(FavoriteError(message: 'Unexpected error'));
    }
  }
}

// States
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteAdded extends FavoriteState {
  final int hadithId;

  FavoriteAdded({required this.hadithId});
}

class FavoriteRemoved extends FavoriteState {
  final int hadithId;

  FavoriteRemoved({required this.hadithId});
}

class FavoritesLoaded extends FavoriteState {
  final FavoriteResponse favorites;

  FavoritesLoaded({required this.favorites});
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}