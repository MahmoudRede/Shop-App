import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopLayout.dart';
import 'package:shop_app/Module/LoginScreen/LoginCubit/cubit.dart';
import 'package:shop_app/Module/LoginScreen/LoginCubit/state.dart';
import 'package:shop_app/Module/RegisterScreen/RegisterScreen.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Companent/constants.dart';
import 'package:shop_app/Shared/Network/local/cacheHelper.dart';
import 'package:shop_app/Shared/Style/colors.dart';


class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginCubit , LoginStates>(
      listener:(context , state){
        if(state is AppLoginSuccessState)
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
                  widget: ShopLayout(),
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
      } ,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        'LOGIN',
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
                        'Login now to browse our hot offers',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
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
                          textType: TextInputType.emailAddress,
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
                        isPassword: LoginCubit.get(context).isPass,
                        sufixIcon: LoginCubit.get(context).sufixIcon,
                        sufixPressed: (){
                          LoginCubit.get(context).changePassword();
                        },
                      ), // FormFeild
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppLoginLoadingState,
                        builder: (context)=>Container(
                          width: double.infinity,
                          height: 50.0,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: MaterialButton(
                            onPressed: (){
                              if (formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                              return null ;
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'LOGIN',
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
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ?',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return RegisterScreen();
                              }));
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100.0,
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
