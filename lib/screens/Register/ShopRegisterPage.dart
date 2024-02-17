import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helper/cach.dart';
import 'package:shop_app/screens/Register/cubit/cubit.dart';
import 'package:shop_app/screens/Register/cubit/state.dart';
import 'package:shop_app/shared/components.dart';

import '../../layout/shoplayout.dart';

class ShopRegisterPage extends StatefulWidget {
  ShopRegisterPage({super.key});

  @override
  State<ShopRegisterPage> createState() => _ShopRegisterPageState();
}

var formkey = GlobalKey<FormState>();

var EmailController = TextEditingController();
var PasswordController = TextEditingController();
var nameController = TextEditingController();
var phoneController = TextEditingController();

class _ShopRegisterPageState extends State<ShopRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              ShowToast(
                  text: state.loginModel.message, state: ToastState.SUCCESS);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayoutScreen());
              });
            } else {
              ShowToast(
                  text: state.loginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
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
                          "Register",
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
                          controller: nameController,
                          type: TextInputType.name,
                          label: "Name",
                          context: context,
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Enter Your Name Please";
                            }
                            return null;
                          },
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
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: "Phone",
                          context: context,
                          prefix: Icons.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Enter Your Phone Please";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: PasswordController,
                          type: TextInputType.visiblePassword,
                          label: "Password",
                          context: context,
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).ispassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changepasswordvisibility();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Your Password Is Too Short";
                            }
                            return null;
                          },
                          onSubmit: (value) {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formkey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: EmailController.text,
                                    password: PasswordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: "Register",
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
