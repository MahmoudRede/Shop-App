import 'package:shop_app/Model/LoginModel.dart';

abstract class RegisterStates{}

class AppRegisterInitialState extends RegisterStates{}

class AppRegisterLoadingState extends RegisterStates {}
class AppRegisterSuccessState extends RegisterStates {
  LoginModel loginModel ;
  AppRegisterSuccessState(this.loginModel);

}
class AppRegisterErrorState extends RegisterStates {
  final String error;

  AppRegisterErrorState(this.error);
}

class AppRegisterChangePasswordState extends RegisterStates{}



