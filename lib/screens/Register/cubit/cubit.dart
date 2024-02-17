import 'package:flutter/material.dart';
import 'package:shop_app/Helper/Dio.dart';
import 'package:shop_app/Helper/Endpoint.dart';
import 'package:shop_app/models/Loginmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/Register/cubit/state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginmodel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(ShopRegisterLoadingState());
    DioHelper.PostData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      print(value?.data);
      loginmodel = ShopLoginModel.fromJson(value?.data);
      /*print(loginmodel?.data?.token);
      print(loginmodel?.status);
      print(loginmodel?.message);*/
      emit(ShopRegisterSuccessState(loginmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changepasswordvisibility() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState1());
  }

  void changepasswordvisibility1() {}
}
