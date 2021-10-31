import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/SearchModel.dart';
import 'package:shop_app/Module/SearchScreen/SearchCubit/states.dart';
import 'package:shop_app/Shared/Companent/constants.dart';
import 'package:shop_app/Shared/Network/EndPoints.dart';
import 'package:shop_app/Shared/Network/remote/DioHelper/DioHelper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search (String text){

    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text' : text,
        },
    ).then((value) {

      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());

    }).catchError((error){
      print('Error when get Search data : ${error.toString()}');
    });
  }

}