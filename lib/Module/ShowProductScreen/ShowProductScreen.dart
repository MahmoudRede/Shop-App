import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Layout/ShopLayout/ShopCubit/ShopState.dart';
import 'package:shop_app/Model/HomeModel.dart';
import 'package:shop_app/Shared/Style/colors.dart';

class ShowProductScreen extends StatelessWidget {
  final model ;

  const ShowProductScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = ShopCubit().get(context).favorites;

        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(model.image!),
                        ),
                        IconButton(
                          onPressed: (){
                            ShopCubit().get(context).changeFavorites(model.id!);
                          },
                          iconSize: 45.0,
                          icon: CircleAvatar(
                            backgroundColor: (cubit[model.id!])! ? Colors.red : Colors.lightBlueAccent,
                            child: Icon(
                              Icons.favorite_border,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            radius: 45.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            model.name!,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Text(
                                'LE',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: defaultColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${model.price!.round()}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: defaultColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              // if (model.discount! != 0 )
                              //   Text(
                              //     '${model.oldPrice!.round()}',
                              //     maxLines: 2,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: TextStyle(
                              //       color: Colors.red,
                              //       fontSize: 12.0,
                              //       fontWeight: FontWeight.bold,
                              //       height: 1.3,
                              //       decoration: TextDecoration.lineThrough,
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45.0,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'وصف المنتج',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          model.description!,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
            ),
            onPressed: (){},
          ),
        );
      },
    );
  }
}
