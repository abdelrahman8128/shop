import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/cubit.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';
import 'package:p4all/layout/shop_app/shop_layout.dart';
import 'package:p4all/modules/shop_app/login/shop_login_screen.dart';
import 'package:p4all/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:p4all/shared/network/local/cache_helper.dart';
import 'package:p4all/shared/network/remote/dio_helper.dart';
import 'package:p4all/shared/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isDarkTheme =(CacheHelper.getDate('isDark')??false);
  bool onBoarding=CacheHelper.getDate('onBoarding')??true ;
  String token= CacheHelper.getDate('token')??'';
 // CacheHelper.putData(key: 'token', value: '');
  Widget widget=OnBoardingScreen();



  if (onBoarding==false)
    {
      print (token);
      if (token !='') {
        widget=ShopLayout();
      } else {
        widget=ShopLoginScreen();
      }

    }
  else {
    widget=OnBoardingScreen();
  }

  runApp(MyApp(
    isDarkTheme,
    widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  bool isDark;
  MyApp(this.isDark,this.startWidget);

  Widget build(BuildContext context) {

    return BlocProvider(create: (context) => ShopCubit(),

      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          print(state.toString());


        },
        builder: (context, state) {

          return MaterialApp(


            debugShowCheckedModeBanner: false,

            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
