abstract class ShopRegisterCubitStates{}

class ShopRegisterInitialState extends ShopRegisterCubitStates{}


class ShopRegisterChangePasswordVisibilityState extends ShopRegisterCubitStates{}

class ShopRegisterLoadingState extends ShopRegisterCubitStates{}

class ShopRegisterSuccessState extends ShopRegisterCubitStates{
  final bool status;
  ShopRegisterSuccessState(this.status);
}
class ShopRegisterErrorState extends ShopRegisterCubitStates{

  final String error;
  ShopRegisterErrorState(this.error);
}
