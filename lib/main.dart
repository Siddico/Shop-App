// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helper/Dio.dart';
import 'package:shop_app/Helper/cach.dart';
//import 'package:shop_app/Helper/cach.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shoplayout.dart';
import 'package:shop_app/screens/Login/ShopLoginPage.dart';
import 'package:shop_app/screens/Register/ShopRegisterPage.dart';
import 'package:shop_app/screens/On_boarding/On_Boarding.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/shared/components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? OnBoarding = CacheHelper.getData(key: 'On_Boarding_View');
  token = CacheHelper.getData(key: 'token');

  print(token);
  if (OnBoarding != null) {
    if (token != null) {
      widget = ShopLayoutScreen();
    } else {
      widget = ShopLoginPage();
    }
  } else {
    widget = On_Boarding_View();
  }
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Shop_App(
        startwidget: widget,
      )));
}

// ignore: must_be_immutable
class Shop_App extends StatelessWidget {
  Widget? startwidget;
  Shop_App({super.key, required this.startwidget});

  @override
  Widget build(BuildContext context) {
    void NavigateTo(context, Widget) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Widget));
    void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Widget),
        (Route<dynamic> route) => false);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..GetHomeData()
              ..GetCategories()
              ..GetCategories()
              ..getUserdata())
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    color: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                        ? Colors.white
                        : Color(0xff333739),
                    shadowColor:
                        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                            ? Colors.white
                            : Color(0xff333739),
                    foregroundColor:
                        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                            ? Colors.white
                            : Color(0xff333739),
                    surfaceTintColor:
                        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                            ? Colors.white
                            : Color(0xff333739),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark),
                    //centerTitle: true,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                      color: Provider.of<ThemeProvider>(context).themeMode ==
                              ThemeMode.light
                          ? Color(0xff333739)
                          : Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedLabelStyle: TextStyle(
                      fontFamily: "Jannah",
                    ),
                    unselectedLabelStyle: TextStyle(fontFamily: "Jannah"),
                    elevation: 100,
                    selectedItemColor: Colors.deepOrange,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff333739)))),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: Color(0xff333739),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xff333739),
                        statusBarIconBrightness: Brightness.light),
                    backgroundColor: Color(0xff333739),
                    //centerTitle: true,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedLabelStyle: TextStyle(
                    fontFamily: "Jannah",
                  ),
                  unselectedLabelStyle: TextStyle(fontFamily: "Jannah"),
                  elevation: 100,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xff333739),
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))),
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            debugShowCheckedModeBanner: false,
            //theme: ThemeData.light(),

            routes: {
              'On_Boarding_View': (context) => On_Boarding_View(),
              'ShopLoginPage': (context) => ShopLoginPage(),
              'ShopRegisterPage': (context) => ShopRegisterPage(),
            },
            home: startwidget,
            //home: ShopLayoutScreen(),
          );
        },
      ),
    );
  }
}
