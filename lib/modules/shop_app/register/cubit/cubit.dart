import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/modules/shop_app/register/cubit/states.dart';
import 'package:p4all/shared/components/components.dart';
import 'package:p4all/shared/network/end_points.dart';
import 'package:p4all/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterCubitStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  bool isPassword=true;
  IconData passwordIcon=Icons.visibility;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    passwordIcon=isPassword? Icons.visibility:Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  void Register({
    required String name,
    required String phone,
    required String email,
    required String password,

}){
    emit(ShopRegisterLoadingState());
    DioHelper.postDate(
        url: REGISTER,
        data:{
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
        },
    ).then((value) {

      emit(ShopRegisterSuccessState(value.data['status']));
      showToast(value.data['message']);

    }).catchError((onError){
      emit(ShopRegisterErrorState(onError.toString()));

    });
  }



}