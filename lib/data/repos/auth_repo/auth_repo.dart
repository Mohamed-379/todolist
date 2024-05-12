
import 'package:flutter/cupertino.dart';
import '../../../data/repos/auth_repo/data_sources/online_data_source.dart';

class AuthRepo
{
  OnlineDataSource onlineDataSource;
  AuthRepo({required this.onlineDataSource});

  void login(BuildContext context, String email, String password){
    onlineDataSource.login(context, email, password);
  }

  void register(BuildContext context, String email, String username, String password){
    onlineDataSource.register(context, email, username, password);
  }

  void delete(BuildContext context){
    onlineDataSource.deleteUser(context);
  }

  void updateUsername(String username)
  {
    onlineDataSource.updateUsername(username);
  }

  void updateEmail(String email)
  {
    onlineDataSource.updateEmail(email);
  }

}