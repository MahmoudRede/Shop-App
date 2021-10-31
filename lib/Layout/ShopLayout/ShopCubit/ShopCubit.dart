import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopState.dart';
import 'package:shop_app/Model/CategoriesModel.dart';
import 'package:shop_app/Model/ChangeFavorites.dart';
import 'package:shop_app/Model/FavoriteModel.dart';
import 'package:shop_app/Model/HomeModel.dart';
import 'package:shop_app/Model/LoginModel.dart';
import 'package:shop_app/Module/CategoriesScreen/CategoriesScreen.dart';
import 'package:shop_app/Module/FavoritesScreen/FavoritesScreen.dart';
import 'package:shop_app/Module/HomeScreen/HomeScreen.dart';
import 'package:shop_app/Module/SettingScreen/SettingScreen.dart';
import 'package:shop_app/Shared/Companent/constants.dart';
import 'package:shop_app/Shared/Network/EndPoints.dart';
import 'package:shop_app/Shared/Network/remote/DioHelper/DioHelper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> HomeScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  int currentIndex = 0 ;

  void changeIndex(int index)
  {
    currentIndex = index ;
    emit(ShopChangeBottomNaviBar());
  }

  HomeModel? homeModel;
  Map <int , bool > favorites = {} ;

  void getHomeData()
  {
    emit(ShopHomeLoadingState());

    DioHelper.geData(
      url: HOME ,
      token: token,
    ).then((value) {

      homeModel = HomeModel.formJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id! : element.inFavorites! ,
        });
      });

      //print(homeModel!.toString());
      emit(ShopHomeSuccessState());

    }).catchError((error){
      print('error when get home data : ${error.toString()}');
      emit(ShopHomeErrorState());

    });

  }


  CategoriesModel? categoriesModel;

  void getCategoriesData()
  {
    DioHelper.geData(
      url: GET_CATEGORIES ,
      token: token,
    ).then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data);

      print(homeModel!.toString());
      emit(ShopHomeSuccessState());

    }).catchError((error){
      print('error when get home  categories data : ${error.toString()}');
      emit(ShopHomeErrorState());

    });

  }


  ChangeFavoritesModel? changeFavoritesModel ;

  void changeFavorites(int id )
  {
    favorites[id] = !(favorites[id])!;
    emit(ShopChangeFavoriteState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data)!;
      print(value.data);

      if(!changeFavoritesModel!.status!)
      {
        favorites[id] = !(favorites[id])!;
        emit(ShopChangeFavoriteState());
      }else{
        getFavoriteData();
      }


      emit(ShopSuccessChangeFavoriteState(changeFavoritesModel!));
    }).catchError((error){
      favorites[id] = !(favorites[id])!;
      print('error in Change Favorites method : ${error.toString()}');
      emit(ShopErrorChangeFavoriteState());
    });
  }



  FavoriteModel? favoriteModel;

  void getFavoriteData()
  {
    emit(ShopLoadingGetFavoriteState());
    DioHelper.geData(
      url: FAVORITES ,
      token: token,
    ).then((value) {

      favoriteModel = FavoriteModel.fromJson(value.data);

      print(favoriteModel!.toString());
      emit(ShopSuccessGetFavoriteState());

    }).catchError((error){
      print('error when get home  Favorite data : ${error.toString()}');
      emit(ShopErrorGetFavoriteState());

    });

  }



  LoginModel? userData;

  void getUserData()
  {
    emit(ShopLoadingGetProfileState());
    DioHelper.geData(
      url: PROFILE ,
      token: token,
    ).then((value) {

      userData = LoginModel.formJson(value.data);

      print(userData!.toString());
      emit(ShopSuccessGetProfileState());

    }).catchError((error){
      print('error when get home profile data : ${error.toString()}');
      emit(ShopErrorGetProfileState());

    });

  }



  void updateUserData({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopUpdateLoadingState());
    DioHelper.putData(
      url: UPDATE ,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {

      userData = LoginModel.formJson(value.data);

      print(userData!.data!.name.toString());
      emit(ShopUpdateSuccessState(userData!));

    }).catchError((error){
      print('error when get home update profile data : ${error.toString()}');
      emit(ShopUpdateErrorState());

    });

  }


}