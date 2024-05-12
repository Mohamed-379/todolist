
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/repos/auth_repo/data_sources/online_data_source.dart';
import '../../../data/repos/auth_repo/auth_repo.dart';

class RegisterViewModel extends Cubit<RegisterState>
{
  RegisterViewModel(): super(RegisterLoadingState());
  AuthRepo authRepo = AuthRepo(onlineDataSource: OnlineDataSource());

  void register(BuildContext context, String email, String username, String password)
  {
    emit(RegisterLoadingState());
    try{
      authRepo.register(context, email, username, password);
      emit(RegisterSuccessState());
    }catch(e){
      emit(RegisterErrorState(errorText: e.toString()));
    }
  }
}

abstract class RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{
  String errorText;
  RegisterErrorState({required this.errorText});
}