import 'package:p4all/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates{}

class shopLogout extends ShopLoginStates{
  final Map<String,dynamic> logout;

  shopLogout(this.logout);
}

class ShopLoginGetUserDataLoadingState extends ShopLoginStates{}

class ShopLoginGetUserDataSuccessState extends ShopLoginStates{}

class ShopLoginGetUserDataErrorState extends ShopLoginStates{}
