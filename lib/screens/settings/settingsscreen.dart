import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/screens/Register/ShopRegisterPage.dart';
import 'package:shop_app/shared/components.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getUserdata();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        if (model != null) {
          namecontroller.text = model.data.name ?? '';
          phonecontroller.text = model.data.phone ?? '';
          emailcontroller.text = model.data.email ?? '';
        }
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel == null,
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      controller: namecontroller,
                      type: TextInputType.name,
                      label: 'Name',
                      context: context,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name Must Be Not Empty';
                        }
                        return null;
                      },
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      context: context,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email Must Be Not Empty';
                        }
                        return null;
                      },
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      controller: phonecontroller,
                      type: TextInputType.phone,
                      label: 'Phone',
                      context: context,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Must Be Not Empty';
                        }
                        return null;
                      },
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                      function: () {
                        SignOut(context);
                      },
                      text: 'LogOut',
                    ),
                    defaultButton(
                      function: () {
                        if (formkey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserdata(
                              name: namecontroller.text,
                              phone: phonecontroller.text,
                              email: emailcontroller.text);
                        }
                      },
                      text: 'Update',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
