import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/models/shop_app/login_model.dart';
import 'package:p4all/modules/shop_app/login/cubit/states.dart';
import 'package:p4all/shared/network/end_points.dart';
import 'package:p4all/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/local/cache_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);


  bool isPassword=true;
  IconData passwordIcon=Icons.visibility;
  ShopLoginModel? loginModel;

  void userLogin(
  {
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postDate(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      },

    ).then((value) {
       loginModel = ShopLoginModel.fromJson(value.data);
       CacheHelper.putData(key: 'token', value: loginModel!.data!.token);


       emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });

  }



   void userLogout(
      {
        required String token,
      }){
    emit(ShopLoginLoadingState());
    DioHelper.postDate(
      url: LOGOUT,
      data: {
        'token':token,
      },

    ).then((value) {

      emit(shopLogout(value as Map<String, dynamic>));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });

  }
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    passwordIcon=isPassword? Icons.visibility:Icons.visibility_off;
    emit(ShopChangePasswordVisibilityState());
  }



}