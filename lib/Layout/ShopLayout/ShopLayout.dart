import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopState.dart';
import 'package:shop_app/Module/LoginScreen/LoginScreen.dart';
import 'package:shop_app/Module/SearchScreen/SearchScreen.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Network/local/cacheHelper.dart';
import 'package:shop_app/Shared/Style/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = ShopCubit().get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
                'Shop',style:TextStyle(color: Color.fromRGBO(19, 21, 23 ,1 )),
            ),
            actions: [
              IconButton(
                  onPressed: ()=>navigateTo(context: context, widget: SearchScreen()),
                  icon: Icon(
                    Icons.search,
                    size: 28.0,
                    color: Color.fromRGBO(19, 21, 23 ,1 ),
                  ),
              ),
            ],
          ),
          body: cubit.HomeScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color.fromRGBO(19, 21, 23 ,1 ),
            onTap: (index){
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.grid_view,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_sharp,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Setting',
              ),
            ],
          ),
        );
      },
    );
  }
}
