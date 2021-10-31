import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/SearchModel.dart';
import 'package:shop_app/Module/SearchScreen/SearchCubit/states.dart';
import 'package:shop_app/Module/ShowProductScreen/ShowProductScreen.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Style/colors.dart';
import 'SearchCubit/cubit.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStates>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Search',style: TextStyle(color: Colors.black,fontSize: 17),),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                    lable: 'Search',
                    textController: searchController,
                    prefixIcon: Icons.search,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Search is empty';
                      }
                    },
                    onSubmit: (String? text){
                      if (formKey.currentState!.validate()){
                        SearchCubit.get(context).search(text!);
                      }
                      return null;
                    },
                    textType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                    height: 10.0,
                  ),
                  if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context , index) => buildSearchItem (SearchCubit.get(context).searchModel!.data!.data![index] , context ),
                        separatorBuilder: (context , index) => SizedBox(height: 20.0,),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchItem ( model , context )
  {
    return GestureDetector(
      onTap: (){
        navigateTo(context: context, widget: ShowProductScreen(model));
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
                  image: NetworkImage(model!.image!),
                  width: 120.0,
                  height: 120.0,
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
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price!}',
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
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            //ShopCubit().get(context).changeFavorites(model.product!.id!);

                          },
                          icon: CircleAvatar(
                            //backgroundColor: ShopCubit().get(context).favorites[model.product!.id!]! ? Colors.red : Colors.lightBlueAccent,
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