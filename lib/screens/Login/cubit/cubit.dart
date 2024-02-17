import 'package:flutter/material.dart';
import 'package:shop_app/Helper/Dio.dart';
import 'package:shop_app/Helper/Endpoint.dart';
import 'package:shop_app/models/Loginmodel.dart';
import 'package:shop_app/screens/Login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginmodel;

  void userlogin({required String email, required String password}) async {
    emit(ShopLoginLoadingState());
    DioHelper.PostData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value?.data);
      loginmodel = ShopLoginModel.fromJson(value?.data);
      /*print(loginmodel?.data?.token);
      print(loginmodel?.status);
      print(loginmodel?.message);*/
      emit(ShopLoginSuccessState(loginmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changepasswordvisibility() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
