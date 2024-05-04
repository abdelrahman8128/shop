// ignore_for_file: prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/cubit.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';
import 'package:p4all/modules/shop_app/login/shop_login_screen.dart';
import 'package:p4all/shared/components/components.dart';

import '../../modules/shop_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeBottomNavState )
          {
            if (ShopCubit.get(context).currentIndex==0)
              {
                ShopCubit.get(context).getHomeData();

              }
          }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(

          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  cubit.userLogout();
                  navigateAndFinish(context, ShopLoginScreen());

                },
                icon: Icon(Icons.logout),
              ),
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),

              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            items: [

              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps_outlined), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            onTap: (index) {
              cubit.changeBottom(index);
            },

          ),
          drawer: Drawer(
            width: MediaQuery.sizeOf(context).width*0.40,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(onPressed:() =>  ShopCubit.get(context).changeAppTheme(), icon: ShopCubit.get(context).isDarkTheme?Icon(Icons.light_mode):Icon(Icons.nightlight_round_rounded)),
              ],
            ),
          ),
        );
      },
    );
  }
}
