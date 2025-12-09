// advanced_search_state.dart
import 'package:equatable/equatable.dart';
import 'package:untitled1/model/advanced_search_model.dart';

abstract class AdvancedSearchState extends Equatable {
  const AdvancedSearchState();

  @override
  List<Object> get props => [];
}

class AdvancedSearchInitial extends AdvancedSearchState {
  const AdvancedSearchInitial();
}

class AdvancedSearchLoading extends AdvancedSearchState {
  const AdvancedSearchLoading();
}

class AdvancedSearchSuccess extends AdvancedSearchState {
  final AdvancedSearchResponse response;
  final bool isFirstPage;

  const AdvancedSearchSuccess({
    required this.response,
    this.isFirstPage = true,
  });

  @override
  List<Object> get props => [response, isFirstPage];
}

class AdvancedSearchError extends AdvancedSearchState {
  final String message;

  const AdvancedSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class AdvancedSearchLoadMore extends AdvancedSearchState {
  const AdvancedSearchLoadMore();
}