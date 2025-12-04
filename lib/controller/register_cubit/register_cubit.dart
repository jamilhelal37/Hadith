import 'package:bloc/bloc.dart';
import 'package:untitled1/controller/register_cubit/register_state.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/model/regester_model.dart';
import 'package:untitled1/services/api_services.dart';



class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

   final ApiRepositry _repo = ApiRepositry();
 
 Future<bool> register(RegesterModel model) async {

    emit(RegisterLooding());
    try {
      bool result = await _repo.regester(model);
    

      if (result) {
        
        emit(RegisterSuccess());
        return result;
      } else {
        emit(RegisterFailed());
       
      }
    } on Exception catch (e) {
      emit(RegisterFailed());
    }
     return false;
  }
}
