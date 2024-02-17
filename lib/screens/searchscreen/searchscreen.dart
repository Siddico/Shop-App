import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/Register/ShopRegisterPage.dart';
import 'package:shop_app/screens/searchscreen/cubit/cubit.dart';
import 'package:shop_app/screens/searchscreen/cubit/states.dart';
import 'package:shop_app/shared/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (contxet, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        label: "Search",
                        context: context,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter Text To Search';
                          }
                          return null;
                        },
                        onSubmit: (text) {
                          SearchCubit.get(context).search(text);
                        },
                        prefix: Icons.search),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProducts(
                            SearchCubit.get(context).model!.data!.data![index],
                            context,
                            isOldPrice: false),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount:
                            SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
