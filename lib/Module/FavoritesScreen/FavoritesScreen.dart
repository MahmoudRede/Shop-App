import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopState.dart';
import 'package:shop_app/Model/FavoriteModel.dart';
import 'package:shop_app/Module/ShowProductScreen/ShowProductScreen.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Style/colors.dart';

class FavoriteScreen extends StatelessWidget {

  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){

        if(ShopCubit().get(context).favoriteModel!.data!.data!.length != 0)
        {
          isEmpty = true;
        }else{
          isEmpty = false;
        }
        return ConditionalBuilder(
          condition: isEmpty,
          builder: (context) => Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.grey[200],
            child: ListView.separated(
              itemBuilder: (context , index) => buildFavoriteItem (ShopCubit().get(context).favoriteModel!.data!.data![index] , context ),
              separatorBuilder: (context , index) => SizedBox(height: 20.0,),
              itemCount: ShopCubit().get(context).favoriteModel!.data!.data!.length,
              physics: BouncingScrollPhysics(),
            ),
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  size: 100,
                  color: Colors.black26,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Your favorites is empty',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget buildFavoriteItem (FavoriteData? model , context )
  {
    return GestureDetector(
      onTap: (){
        navigateTo(context: context, widget: ShowProductScreen(model!.product!));
      },
      child: Container(
        height: 145.0,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.product!.image!),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.product!.discount! != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price!}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: defaultColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        //if (model.discount != 0)
                        Text(
                          '${model.product!.oldPrice!}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            ShopCubit().get(context).changeFavorites(model.product!.id!);

                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit().get(context).favorites[model.product!.id!]! ? Colors.red : Colors.lightBlueAccent,
                            child: Icon(
                              Icons.favorite_border,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
