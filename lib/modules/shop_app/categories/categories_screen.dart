// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/cubit.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';

import '../../../shared/components/components.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  void initState() {
    super.initState();
    ShopCubit.get(context).getCategoriesData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is ShopLoadingCategoriesDataState,
          builder: (context) => Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
          )),
          fallback: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 1,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1.5 / 1,
                    children: List.generate(
                        ShopCubit.get(context).categoriesModel!.data!.data.length,
                        (index) => buildGridCategoryItem(ShopCubit.get(context)
                            .categoriesModel!
                            .data
                            !.data[index])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
