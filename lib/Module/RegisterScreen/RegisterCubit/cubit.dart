import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/LoginModel.dart';
import 'package:shop_app/Module/LoginScreen/LoginCubit/state.dart';
import 'package:shop_app/Module/RegisterScreen/RegisterCubit/state.dart';
import 'package:shop_app/Shared/Network/EndPoints.dart';
import 'package:shop_app/Shared/Network/remote/DioHelper/DioHelper.dart';


class RegisterCubit extends Cubit <RegisterStates>{
  RegisterCubit() : super(AppRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  var  loginModel ;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email ,
        'password': password ,
      },
    ).then((value) {

      loginModel = LoginModel.formJson(value.data);
      LoginModel.formJson(value.data);
      emit(AppRegisterSuccessState(LoginModel.formJson(value.data)));
    }).catchError((error){
      print('error when post login data ${error.toString()}');
      emit(AppRegisterErrorState(error));
    });
  }

  bool isPass = true;
  IconData sufixIcon = Icons.visibility;

  void changePassword ()
  {
    isPass =! isPass;
    sufixIcon = isPass ? Icons.visibility : Icons.visibility_off;
    emit(AppRegisterChangePasswordState());
  }



}
