import 'package:shop_app/Model/LoginModel.dart';

abstract class LoginStates{}

class AppLoginInitialState extends LoginStates{}

class AppLoginLoadingState extends LoginStates {}
class AppLoginSuccessState extends LoginStates {
  LoginModel loginModel ;
  AppLoginSuccessState(this.loginModel);

}
class AppLoginErrorState extends LoginStates {
  final String error;

  AppLoginErrorState(this.error);
}


class AppLoginChangePasswordState extends LoginStates{}



