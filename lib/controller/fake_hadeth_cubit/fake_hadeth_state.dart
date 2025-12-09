part of 'fake_hadeth_cubit.dart';

@immutable
sealed class FakeHadethState {}

final class FakeHadethInitial extends FakeHadethState {}
final class FakeHadethLooding extends FakeHadethState {}
final class FakeHadethSuccess extends FakeHadethState {
  List<FakeHadethModel> fake_hadeths;
  FakeHadethSuccess(this.fake_hadeths);
}
final class FakeHadethFailur extends FakeHadethState {
FakeHadethFailur(this.errMessege);

  String errMessege;
  
}
