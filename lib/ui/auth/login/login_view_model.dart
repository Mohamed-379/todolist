import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/auth_repo/auth_repo.dart';
import '../../../data/repos/auth_repo/data_sources/online_data_source.dart';

class LoginViewModel extends Cubit<LoginState>
{
  LoginViewModel(): super(LoginLoadingState());
  AuthRepo authRepo = AuthRepo(onlineDataSource: OnlineDataSource());

  void login(BuildContext context, String email, String password){
    emit(LoginLoadingState());
    try{
      authRepo.login(context, email, password);
      emit(LoginSuccessState());
    }catch(e){
      emit(LoginErrorState(errorText: e.toString()));
    }
  }
}

abstract class LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{}
class LoginErrorState extends LoginState{
  String errorText;
  LoginErrorState({required this.errorText});
}