import 'package:shop_app/models/Loginmodel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String? error;
  ShopRegisterErrorState(String string, {this.error});
}

class ShopChangePasswordVisibilityState1 extends ShopRegisterStates {}
