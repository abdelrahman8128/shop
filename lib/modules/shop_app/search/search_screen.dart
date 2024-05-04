// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/cubit.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';

import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                DefaultTextFeild(
                  color: Colors.deepOrange,
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  onSubmit: (String value) {
                    ShopCubit.get(context).search(text: '$value');
                  },
                ),
                SizedBox(height: 15,),
                Expanded(

                  child: ConditionalBuilder(
                    condition:
                        ShopCubit.get(context).searchModel?.products != null,
                    builder: (context) => GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      physics: BouncingScrollPhysics(),
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1/1.75,
                      children: List.generate(
                          ShopCubit.get(context).searchModel!.products.length-1,
                          (index) => buildGridProductItem(
                              ShopCubit.get(context)
                                  .searchModel!
                                  .products[index])),
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
