import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopState.dart';
import 'package:shop_app/Model/CategoriesModel.dart';
import 'package:shop_app/Model/HomeModel.dart';
import 'package:shop_app/Module/ShowProductScreen/ShowProductScreen.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Style/colors.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSuccessChangeFavoriteState)
            {
              if(!state.model.status!)
                {
                  showToast(text: state.model.message.toString(), state: ToastState.ERROR);
                }
            }
        },
        builder: (context, state) {
          var cubit = ShopCubit().get(context);

          return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => homeBuilder(cubit.homeModel , cubit.categoriesModel , context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget homeBuilder(HomeModel? model , CategoriesModel? CategModel , context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: model!.data!.banners.map((e) {
              return Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
              }).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              //aspectRatio: 16/9,
              enableInfiniteScroll: true,
              reverse: false ,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800 ,),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                    color:  Color.fromRGBO(19, 21, 23 ,1 ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  ),
                  child: ListView.separated(
                      itemBuilder: (context , index) => categoriesItem(CategModel!.data!.data![index]),
                      separatorBuilder: (context , index) => SizedBox(width: 10.0,),
                      itemCount: CategModel!.data!.data!.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                    color:  Color.fromRGBO(19, 21, 23 ,1 ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(5.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1/1.85,
              children: List.generate(
                  model.data!.products.length ,
                    (index) => gridProductItem(model.data!.products[index] , context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridProductItem(ProductsModel model , context){
    var cubit = ShopCubit().get(context).favorites;
    return GestureDetector(
      onTap: (){
        //print('Item index : $index');
        navigateTo(context: context, widget: ShowProductScreen(model));
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
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
                      if (model.discount != 0)
                        Text(
                        '${model.oldPrice.round()}',
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
                          ShopCubit().get(context).changeFavorites(model.id!);

                        },
                        icon: CircleAvatar(
                          backgroundColor: (cubit[model.id!])! ? Colors.red : Colors.lightBlueAccent,
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
          ],
        ),
      ),
    );
  }

  Widget categoriesItem (DataModel model) {
    return Container(
      width: 100.0,
      height: 100.0,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 120.0,
            color: Colors.black.withOpacity(0.7),
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              model.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

}
