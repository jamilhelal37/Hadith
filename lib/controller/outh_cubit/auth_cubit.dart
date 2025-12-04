import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/model/login_model.dart';
import 'package:untitled1/services/api_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final ApiRepositry _repo = ApiRepositry();
 
 Future<bool> login(LoginModel loginModel) async {

    emit(AuthLooding());
    try {
      bool result = await _repo.login(loginModel)??false;
      sharedPrf.setString('isLogin', loginModel.email);

      if (result) {
        emit(AuthSuccess());
        return true;
      } else {
        emit(AuthFailed());
        return false;
      }
    } on Exception catch (e) {
      emit(AuthFailed());
      return false;
    }
  }
}
