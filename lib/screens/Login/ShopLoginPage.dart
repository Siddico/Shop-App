//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:shop_app/Helper/cach.dart';
//import 'package:shop_app/Helper/cach.dart';
import 'package:shop_app/layout/shoplayout.dart';
//import 'package:shop_app/main.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/Login/cubit/cubit.dart';
import 'package:shop_app/screens/Login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/shared/components.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ShopLoginPage extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  ShopLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
            listener: (BuildContext context, Object? state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              /* print(state.loginModel.data?.token);
              print(state.loginModel.message);*/
              // CachHelper.saveData(key:'token',value:state.loginModel.token!);
              ShowToast(
                  text: state.loginModel.message, state: ToastState.SUCCESS);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayoutScreen());
              });
              /*CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                String token = state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLayoutScreen());
              });*/
            } else {
              /*print(state.loginModel.message);*/
              ShowToast(
                  text: state.loginModel.message, state: ToastState.ERROR);
            }
          }
        }, builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontFamily: "Jannah"),
                        ),
                        Text(
                          "Login Now To Browse Our Hot Offers",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Jannah"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: EmailController,
                          type: TextInputType.emailAddress,
                          label: "Email Address",
                          context: context,
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Enter Your Email Address";
                            }
                            return null;
                          },
                        ),
                        defaultFormField(
                          controller: PasswordController,
                          type: TextInputType.visiblePassword,
                          label: "Password",
                          context: context,
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).ispassword,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changepasswordvisibility();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Your Password Is Too Short";
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (formkey.currentState?.validate() ?? false) {
                              ShopLoginCubit.get(context).userlogin(
                                email: EmailController.text,
                                password: PasswordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userlogin(
                                    email: EmailController.text,
                                    password: PasswordController.text);
                              }
                            },
                            text: "Login",
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have An Account ?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "ShopRegisterPage");
                              },
                              child: Text("Register"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
