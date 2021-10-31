import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/LoginModel.dart';
import 'package:shop_app/Module/LoginScreen/LoginCubit/state.dart';
import 'package:shop_app/Shared/Network/EndPoints.dart';
import 'package:shop_app/Shared/Network/remote/DioHelper/DioHelper.dart';


class LoginCubit extends Cubit <LoginStates>{
  LoginCubit() : super(AppLoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  var  loginModel ;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':'$email',
        'password':'$password',
      },
    ).then((value) {
      //print('${value.data}');
      loginModel = LoginModel.formJson(value.data);
      LoginModel.formJson(value.data);
      emit(AppLoginSuccessState(LoginModel.formJson(value.data)));
    }).catchError((error){
      print('error when post login data ${error.toString()}');
      emit(AppLoginErrorState(error));
    });
  }

  bool isPass = true;
  IconData sufixIcon = Icons.visibility;

  void changePassword ()
  {
    isPass =! isPass;
    sufixIcon = isPass ? Icons.visibility : Icons.visibility_off;
    emit(AppLoginChangePasswordState());
  }



}
