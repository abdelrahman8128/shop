
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/cubit.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';
import 'package:p4all/shared/components/components.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void initState() {
    super.initState();
    if (ShopCubit.get(context).favorites.isEmpty) {
      ShopCubit.get(context).getHomeData();
    }
    ShopCubit.get(context).getFavorites();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopFavoritesChangeState)
          {
            setState(() {

            });
          }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is ShopLoadingFavoritesDataState,
          builder: (context) => const Center(child: CircularProgressIndicator()),
          fallback: (context) =>ConditionalBuilder(
              condition: ShopCubit.get(context).favoritesModel!.data.data.products.isEmpty,
              builder: (context) => const Center(child: Text('your favorites list is empty'),),
              fallback: (context) =>  Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildGridFavoritesItem(
                            ShopCubit.get(context).favoritesModel!.data.data.products[index],
                            context),
                        separatorBuilder: (context, index) {
                          return Container(
                            color: Colors.grey[500],
                            height: 1,
                            width: double.infinity,
                          );
                        },
                        itemCount:ShopCubit.get(context).favoritesModel!.data.data.products.length,
                      ),
                      Container(
                        color: Colors.grey[500],
                        height: 1,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
          )
        );
      },
    );
  }
}
