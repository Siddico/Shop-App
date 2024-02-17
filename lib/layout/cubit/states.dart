import 'package:shop_app/models/Loginmodel.dart';
import 'package:shop_app/models/changefavouritesmodel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavigateState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  late final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  late final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavouritesState extends ShopStates {}

class ShopSuccessChangeFavouritesState extends ShopStates {
  final ChangeFavouritesModel model;
  ShopSuccessChangeFavouritesState({required this.model});
}

class ShopErrorChangeFavouritesState extends ShopStates {
  late final String error;
  ShopErrorChangeFavouritesState(this.error);
}

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {
  late final String error;
  ShopErrorGetFavouritesState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginmodel;
  ShopSuccessUserDataState({required this.loginmodel});
}

class ShopErrorUserDataState extends ShopStates {
  late final String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateDataState extends ShopStates {}

class ShopSuccessUpdateDataState extends ShopStates {
  final ShopLoginModel loginmodel;
  ShopSuccessUpdateDataState({required this.loginmodel});
}

class ShopErrorUpdateDataState extends ShopStates {
  late final String error;
  ShopErrorUpdateDataState(this.error);
}
