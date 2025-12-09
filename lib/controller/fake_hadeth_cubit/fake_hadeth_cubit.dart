import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/model/fake_hadeth_model.dart';
import 'package:untitled1/services/fake_hadeth_repo.dart';

part 'fake_hadeth_state.dart';

class FakeHadethCubit extends Cubit<FakeHadethState> {
  FakeHadethCubit() : super(FakeHadethInitial());
  FakeHadethRepo repo=FakeHadethRepo();

  getFakeHadeths()async{
      emit(FakeHadethLooding());
      try{

         List<FakeHadethModel> res = await repo.getFakeHadeth();
        emit(FakeHadethSuccess(res));
      }catch(e){
        emit(FakeHadethFailur(e.toString()));
      }
      
  }
}
