import 'package:shop_app/models/Loginmodel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String? error;
  ShopLoginErrorState(String string, {this.error});
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}
