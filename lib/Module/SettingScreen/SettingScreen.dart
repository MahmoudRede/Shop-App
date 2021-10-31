import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopState.dart';
import 'package:shop_app/Module/LoginScreen/LoginScreen.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Network/local/cacheHelper.dart';
import 'package:shop_app/Shared/Style/colors.dart';

class SettingScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){

        var model = ShopCubit().get(context).userData;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit().get(context).userData != null,
          builder: (context) => Scaffold(
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(state is ShopUpdateLoadingState)
                        LinearProgressIndicator(),
                        SizedBox(height: 20.0,),
                      defaultFormField(
                        lable: 'Name',
                        textController: nameController,
                        prefixIcon: Icons.person,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                        textType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        lable: 'Email',
                        textController: emailController,
                        prefixIcon: Icons.email,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        textType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        lable: 'Phone',
                        textController: phoneController,
                        prefixIcon: Icons.phone,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Phone Number must not be empty';
                          }
                          return null;
                        },
                        textType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: MaterialButton(
                          onPressed: (){
                            if (formKey.currentState!.validate()){
                              ShopCubit().get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),

                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: double.infinity,
                        height: 50.0,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          onPressed: (){
                            if (formKey.currentState!.validate()){
                              CacheHelper.removeData(key:'token').then((value)
                              {
                                if(value == true)
                                {
                                  navigateAndRemove(context: context, widget: LoginScreen(),);
                                }
                              });
                            }
                            return null;
                          },
                          color: Colors.blue,
                          child: Text(
                            'LOGOUT',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}