// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/cubit.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';
import 'package:p4all/shared/components/components.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}
class _ProductsScreenState extends State<ProductsScreen> {

  @override
  void initState() {
    super.initState();
    ShopCubit.get(context).getHomeData();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {

        },
        builder:(context, state) {
         return ConditionalBuilder(
              condition: state is ShopLoadingHomeDataState,
           builder: (context) {
             return Center(child: CircularProgressIndicator());
           },
              fallback: (context) {
                return  SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        CarouselSlider(

                          items: ShopCubit.get(context).homeModel!.data.banners.map((e) => buildBannerItem(e)
                          ).toList(),

                          options: CarouselOptions(

                              height: 250,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 500),
                              autoPlayCurve: Curves.fastLinearToSlowEaseIn
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                            color: Colors.grey[300],
                            child: GridView.count(
                              shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                                childAspectRatio: 1/1.58,
                                children: List.generate(ShopCubit.get(context).homeModel!.data.products.length, (index) =>buildGridProductItem( ShopCubit.get(context).homeModel!.data.products[index])),
                            ),
                          ),

                      ],
                    ),
                  );


              },

          );
        },
    );


    //   Scaffold(
    //   appBar: AppBar(),
    //   body: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     clipBehavior: Clip.antiAlias,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.max,
    //       children:[
    //         Container(
    //           height: 250,
    //           child: ListView.separated(
    //             itemBuilder: (context, index) => buildBannerItem(context,homeModel!.data.banners[index]),
    //             itemCount: 8,
    //             scrollDirection: Axis.horizontal,
    //             separatorBuilder: (context, index) => SizedBox(width: 4,),
    //           ),
    //         ),
    //         Column(
    //           children: [
    //           Container(
    //             height: 250,
    //             child: ListView.separated(
    //               itemBuilder: (context, index) => buildBannerItem(context,homeModel!.data.banners[index]),
    //               itemCount: 8,
    //               scrollDirection: Axis.vertical,
    //               separatorBuilder: (context, index) => SizedBox(width: 4,),
    //             ),
    //           ),
    //
    //           ],
    //         ),
    //       ],
    //
    //     ),
    //   ),
    // );
  }
}
