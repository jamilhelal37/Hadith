// cubits/hadith_cubit.dart

import '../../model/search_model.dart';

abstract class HadithState {}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithSuccess extends HadithState {
  final HadithModel hadithModel;

  HadithSuccess(this.hadithModel);
}

class HadithError extends HadithState {
  final String message;

  HadithError(this.message);
}