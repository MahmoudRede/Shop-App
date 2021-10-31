// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/OnBoarding/OnBoardingScreen.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopState.dart';
import 'package:shop_app/Layout/ShopLayout/ShopLayout.dart';
import 'package:shop_app/Module/LoginScreen/LoginScreen.dart';
import 'package:shop_app/Module/RegisterScreen/RegisterCubit/cubit.dart';
import 'package:shop_app/Module/SearchScreen/SearchCubit/cubit.dart';
import 'package:shop_app/Shared/Network/local/cacheHelper.dart';
import 'package:shop_app/Shared/Network/remote/DioHelper/DioHelper.dart';
import 'package:shop_app/Shared/Style/colors.dart';
import 'package:shop_app/Shared/Style/themes.dart';
import 'Layout/ShopLayout/ShopCubit/ShopCubit.dart';
import 'Module/LoginScreen/LoginCubit/cubit.dart';
import 'Shared/Companent/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    onBoarding: onBoarding,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget widget;

  MyApp({
    this.onBoarding,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SearchCubit(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
