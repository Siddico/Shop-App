import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helper/Dio.dart';
import 'package:shop_app/Helper/Endpoint.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/Loginmodel.dart';
import 'package:shop_app/models/categoriesmodel.dart';
import 'package:shop_app/models/changefavouritesmodel.dart';
import 'package:shop_app/models/getfavouritesmodel.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/screens/category/categoryscreen.dart';
import 'package:shop_app/screens/favourite/favouritescreen.dart';
import 'package:shop_app/screens/products/proudctsscreen.dart';
import 'package:shop_app/screens/settings/settingsscreen.dart';
import 'package:shop_app/shared/components.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<Widget> BottomScreens = [
    ProuductsScreen(),
    CategoryScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  void ChangeBottom(int index) {
    CurrentIndex = index;
    emit(ShopChangeBottomNavigateState());
  }

  HomeModel? homeModel;

  Map<int, bool> favourites = {};
  void GetHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.GetData(url: HOME, token: token).then((value) {
      if (value != null) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products.forEach(
          (element) {
            favourites.addAll({element.id: element.in_favorites});
          },
        );
        emit(ShopSuccessHomeDataState());
      } else {
        emit(ShopErrorHomeDataState("Failed to fetch data"));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.error is SocketException) {
          emit(ShopErrorHomeDataState(
              "Network error. Please check your internet connection."));
        } else {
          emit(ShopErrorHomeDataState(
              "An error.. occurred. Please try again later."));
        }
      } else {
        emit(ShopErrorHomeDataState(
            "An error occurred. Please try again later."));
      }
    });
  }

  CategoriesModel? categoriesModel;
  void GetCategories() {
    DioHelper.GetData(url: Get_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value!.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavouritesModel? changefavouritesmodel;
  void changeFavourites(int product_id) {
    favourites[product_id] = !favourites[product_id]!;
    emit(ShopChangeFavouritesState());
    favourites[product_id] = !favourites[product_id]!;
    DioHelper.PostData(
            url: FAVOURITES, data: {'product_id': product_id}, token: token)
        .then((value) {
      changefavouritesmodel = ChangeFavouritesModel.fromJson(value?.data);
      print(value?.data);
      if (!changefavouritesmodel!.status!) {
        favourites[product_id] = !favourites[product_id]!;
      } else {
        GetFavourites();
      }
      favourites[product_id] = !favourites[product_id]!;
      emit(ShopSuccessChangeFavouritesState(model: changefavouritesmodel!));
    }).catchError((error) {
      favourites[product_id] = !favourites[product_id]!;
      emit(ShopErrorChangeFavouritesState(error));
    });
  }

  FavoritesModel? favouritesModel;
  void GetFavourites() {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.GetData(url: FAVOURITES, token: token).then((value) {
      favouritesModel = FavoritesModel?.fromJson(value?.data);
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavouritesState(error.toString()));
    });
  }

  ShopLoginModel? userModel;
  void getUserdata() {
    emit(ShopLoadingUserDataState());
    DioHelper.GetData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value?.data);
      print(userModel!.data.name);
      emit(ShopSuccessUserDataState(loginmodel: userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  void updateUserdata(
      {required String name, required String phone, required String email}) {
    emit(ShopLoadingUpdateDataState());
    DioHelper.PutData(
        url: UPDATE_PROFILE,
        token: token,
        data: {'name': name, 'phone': phone, 'email': email}).then((value) {
      userModel = ShopLoginModel.fromJson(value?.data);
      print(userModel!.data.name);
      emit(ShopSuccessUpdateDataState(loginmodel: userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateDataState(error.toString()));
    });
  }
}
