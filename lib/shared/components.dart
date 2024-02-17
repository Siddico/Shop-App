import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Helper/cach.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/screens/Login/ShopLoginPage.dart';

Widget defaultButton(
        {double? width,
        double height = 60,
        Color background = Colors.white,
        bool isUpperCase = false,
        required VoidCallback function,
        required String text,
        double fontSize = 20}) =>
    Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        width: width != null ? width : double.infinity,
        height: height,
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                color: Colors.white, fontSize: fontSize, fontFamily: "Jannah"),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 39, 78, 156),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(color: Colors.green),
      ),
    );

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

/*Widget socialButton({
  GestureTapCallback? onTap,
  String? text,
  //String? image,
  Color? txtColor,
  Color? btnColor,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/${image}',
            //   height: 20,
            //   width: 26,
            // ),
            Text(
              '${text}',
              style: TextStyle(color: txtColor, fontSize: 15),
            ),
          ],
        ),
      ),
    );
    */

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  bool isPassword = false,
  ValueChanged? onChanged,
  GestureTapCallback? onTap,
  FormFieldValidator<String>? validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  bool underLine = true,
  required var context,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.red,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 39, 78, 156),
            )),
        labelStyle: TextStyle(
            //color: DocCubit.get(context).isDark
            //  ? Colors.white
            //: Colors.black.withOpacity(.5),
            ),
        labelText: label,
        prefixIcon: Icon(
          prefix, color: Colors.black,
          // color: DocCubit.get(context).isDark
          //   ? Colors.white
          // : Colors.black.withOpacity(.5),
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix, color: Colors.black,
                  // color: DocCubit.get(context).isDark
                  //   ? Colors.white
                  // : Colors.black.withOpacity(.5),
                ),
              )
            : null,

        //underLine ? UnderlineInputBorder() : InputBorder.none,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void ShowToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WORNING }

Color? chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WORNING:
      color = Colors.amber;
      break;
  }
  return color;
}

String? token;

void SignOut(context) {
  CacheHelper.removeDate(
    key: 'token',
  ).then((value) {
    if (value!) {
      navigateAndFinish(context, ShopLoginPage());
    }
  });
}

Widget buildListProducts(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Container(
              width: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                    model.image,
                    height: 120,
                    width: 120,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: Text(
                        'Discount',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.2,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          style: TextStyle(
                              height: 1.2,
                              color: Color.fromARGB(255, 7, 111, 196)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            '${model.oldPrice.toString()}',
                            style: TextStyle(
                                height: 1.2,
                                decoration: TextDecoration.lineThrough,
                                color: Color.fromARGB(255, 221, 104, 9)),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavourites(model.id);
                            },
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    ShopCubit.get(context).favourites[model.id]!
                                        ? Colors.blue
                                        : Colors.grey,
                                child: Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.white,
                                )))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
