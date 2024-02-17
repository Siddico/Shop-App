import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helper/Dio.dart';
import 'package:shop_app/Helper/Endpoint.dart'; // Update the import statement
import 'package:shop_app/models/searchmodel.dart';
import 'package:shop_app/screens/searchscreen/cubit/states.dart';
import 'package:shop_app/shared/components.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    DioHelper.PostData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      model = SearchModel.fromJson(value!.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
