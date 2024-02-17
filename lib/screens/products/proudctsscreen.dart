import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/models/categoriesmodel.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/shared/components.dart';

class ProuductsScreen extends StatelessWidget {
  ProuductsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavouritesState) {
          if (!state.model.status!) {
            ShowToast(text: state.model.message!, state: ToastState.ERROR);
          } else {
            ShowToast(text: state.model.message!, state: ToastState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        return Center(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => homeBuilderWidget(
                ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!,
                context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget homeBuilderWidget(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image.network(
                        '${e.image}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildCategoryItem(categoriesModel.data!.data[index]),

                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemCount: categoriesModel.data!.data.length,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'New Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: const Color.fromARGB(255, 226, 226, 226),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1 / 1.6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      BuildGridProduct(model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget BuildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  model.image,
                  height: 200,
                  width: double.infinity,
                  // fit: BoxFit.cover,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
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
                        '${model.price.round()}',
                        style: TextStyle(
                            height: 1.2,
                            color: Color.fromARGB(255, 7, 111, 196)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.old_price.round()}',
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
            )
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Container(
        width: 100,
        height: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 100,
              height: 100,
            ),
            Container(
                width: double.infinity,
                color: Colors.black.withOpacity(.6),
                child: Text(
                  model.name!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      );
}
