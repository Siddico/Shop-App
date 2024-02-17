import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categoriesmodel.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoryItem(
                ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCategoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      );
}
