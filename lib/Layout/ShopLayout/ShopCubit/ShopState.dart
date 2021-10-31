import 'package:shop_app/Model/ChangeFavorites.dart';
import 'package:shop_app/Model/LoginModel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNaviBar extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}
class ShopHomeSuccessState extends ShopStates {}
class ShopHomeErrorState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}
class ShopCategoriesErrorState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);

}
class ShopChangeFavoriteState extends ShopStates {}
class ShopErrorChangeFavoriteState extends ShopStates {}

class ShopLoadingGetFavoriteState extends ShopStates {}
class ShopSuccessGetFavoriteState extends ShopStates {}
class ShopErrorGetFavoriteState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}
class ShopSuccessGetProfileState extends ShopStates {}
class ShopErrorGetProfileState extends ShopStates {}

class ShopUpdateLoadingState extends ShopStates {}
class ShopUpdateSuccessState extends ShopStates {
  final LoginModel loginModel ;
  ShopUpdateSuccessState(this.loginModel);

}
class ShopUpdateErrorState extends ShopStates {}