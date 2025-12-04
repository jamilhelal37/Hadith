
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterSuccess extends RegisterState {}
final class RegisterFailed extends RegisterState {}
final class RegisterLooding extends RegisterState {}

