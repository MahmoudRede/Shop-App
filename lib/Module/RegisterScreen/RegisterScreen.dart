import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopLayout.dart';
import 'package:shop_app/Module/LoginScreen/LoginScreen.dart';
import 'package:shop_app/Module/RegisterScreen/RegisterCubit/cubit.dart';
import 'package:shop_app/Module/RegisterScreen/RegisterCubit/state.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Companent/constants.dart';
import 'package:shop_app/Shared/Network/local/cacheHelper.dart';
import 'package:shop_app/Shared/Style/colors.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit , RegisterStates>(
      listener: (context , state){
        if(state is AppRegisterSuccessState)
        {
          if(state.loginModel.status == true){
            print(state.loginModel.message);
            print(state.loginModel.data!.token);
            showToast(
              text: state.loginModel.message!,
              state: ToastState.SUCCESS,
            );
            CacheHelper.saveData(
                key:'token',
                value: state.loginModel.data!.token).then((value)
            {
              token = state.loginModel.data!.token!;
              navigateAndRemove(
                context: context,
                widget: LoginScreen(),
              );
            });
          }else
          {
            print(state.loginModel.message);
            showToast(
              text: state.loginModel.message!,
              state: ToastState.ERROR,
            );
          }
        }
      },
      builder: (context , state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        lable: 'Name',
                        textController: nameController,
                        prefixIcon: Icons.email_outlined,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'please enter your name';
                          }
                        },
                        textType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        lable: 'Phone',
                        textController: phoneController,
                        prefixIcon: Icons.lock_outline,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Incorrect phone number';
                          }
                        },
                        textType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          lable: 'Email',
                          textController: emailController,
                          prefixIcon: Icons.email_outlined,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter email address';
                            }
                          },
                          textType: TextInputType.emailAddress
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        lable: 'Password',
                        textController: passwordController,
                        prefixIcon: Icons.lock_outline,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Incorrect password';
                          }
                        },
                        isPassword: RegisterCubit.get(context).isPass,
                        sufixIcon: RegisterCubit.get(context).sufixIcon,
                        sufixPressed: (){
                          RegisterCubit.get(context).changePassword();
                        },
                      ), // FormFeild
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppRegisterLoadingState,
                        builder: (context)=>Container(
                          width: double.infinity,
                          height: 50.0,
                          padding: EdgeInsets.fromLTRB(10, 0,10, 0),
                          child: MaterialButton(
                            onPressed: (){
                              if (formKey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                showToast(text: 'Register Successful', state: ToastState.SUCCESS);
                              }
                              return null ;
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context)=> Center(child: CircularProgressIndicator()),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
