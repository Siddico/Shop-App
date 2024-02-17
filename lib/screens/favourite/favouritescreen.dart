import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import '../../shared/components.dart';
//import 'package:shop_app/models/getfavouritesmodel.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).changefavouritesmodel != null,
          //state is ShopLoadingGetFavouritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProducts(
              ShopCubit.get(context)
                  .favouritesModel!
                  .data!
                  .data![index]
                  .product,
              context,
            ),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
                ShopCubit.get(context).favouritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
