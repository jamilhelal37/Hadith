// advanced_search_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:untitled1/model/advanced_search_model.dart';
import '../../services/advanced_search_repo.dart';
import 'advanced_search_state.dart';

class AdvancedSearchCubit extends Cubit<AdvancedSearchState> {
  final AdvancedSearchRepository _repository;

  AdvancedSearchCubit(this._repository) : super(const AdvancedSearchInitial());

  AdvancedSearchRequest? _currentRequest;
  AdvancedSearchResponse? _currentResponse;

  Future<void> search({
    String? query,
    int? muhaddithId,
    int? rawiId,
    int? subjectId,
    int? bookId,
    int? rulingId,
  }) async {
    try {
      final request = AdvancedSearchRequest(
        query: query,
        muhaddithId: muhaddithId,
        rawiId: rawiId,
        subjectId: subjectId,
        bookId: bookId,
        rulingId: rulingId,
        page: 1,
        limit: 20,
      );

      _currentRequest = request;
      emit(const AdvancedSearchLoading());
      final response = await _repository.advancedSearch(request);
      _currentResponse = response;

      emit(AdvancedSearchSuccess(response: response, isFirstPage: true));
    } catch (e) {
      emit(AdvancedSearchError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    try {
      if (_currentRequest == null ||
          _currentResponse == null ||
          _currentResponse?.hasMore != true) {
        return;
      }

      emit(const AdvancedSearchLoadMore());

      final nextPageRequest = AdvancedSearchRequest(
        query: _currentRequest!.query,
        muhaddithId: _currentRequest!.muhaddithId,
        rawiId: _currentRequest!.rawiId,
        subjectId: _currentRequest!.subjectId,
        bookId: _currentRequest!.bookId,
        rulingId: _currentRequest!.rulingId,
        page: (_currentResponse!.page ?? 1) + 1,
        limit: _currentRequest!.limit,
      );

      final response = await _repository.advancedSearch(nextPageRequest);

      // Merge results
      final mergedData = [
        ..._currentResponse!.data,
        ...response.data,
      ];

      final mergedResponse = AdvancedSearchResponse(
        data: mergedData,
        total: response.total,
        page: response.page,
        totalPages: response.totalPages,
        hasMore: response.hasMore,
      );

      _currentResponse = mergedResponse;

      emit(AdvancedSearchSuccess(
        response: mergedResponse,
        isFirstPage: false,
      ));
    } catch (e) {
      emit(AdvancedSearchError(e.toString()));
    }
  }

  void clearSearch() {
    _currentRequest = null;
    _currentResponse = null;
    emit(const AdvancedSearchInitial());
  }

  bool get hasMoreResults {
    if (_currentResponse == null) return false;
    return _currentResponse!.hasMore == true;
  }
}