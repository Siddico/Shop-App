import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shop_app/Helper/cach.dart';
//import 'package:shop_app/screens/Login/ShopLoginPage.dart';
import 'package:shop_app/screens/searchscreen/searchscreen.dart';
import 'package:shop_app/shared/components.dart';

class ShopLayoutScreen extends StatelessWidget {
  ShopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopErrorHomeDataState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Shop App"),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.BottomScreens[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.ChangeBottom(index);
              },
              currentIndex: cubit.CurrentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: "Categories"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favourites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings")
              ]),
        );
      },
    );
  }
}
