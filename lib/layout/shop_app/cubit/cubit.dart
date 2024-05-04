

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';
import 'package:p4all/models/shop_app/favorites_model.dart';
import 'package:p4all/models/shop_app/home_model.dart';
import 'package:p4all/models/shop_app/login_model.dart';
import 'package:p4all/modules/shop_app/favorites/favorites_screen.dart';
import 'package:p4all/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:p4all/shared/components/components.dart';
import 'package:p4all/shared/network/local/cache_helper.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/search_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';



class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit(): super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  HomeModel? homeModel=HomeModel();
  CategoriesModel? categoriesModel=CategoriesModel();
  FavoritesModel? favoritesModel=FavoritesModel();
  ShopLoginModel?shopLoginModel=ShopLoginModel();

  bool readOnly=true;
  SearchModel?searchModel;

  bool isDarkTheme =(CacheHelper.getDate('isDark')??false);
  bool onBoarding=CacheHelper.getDate('onBoarding')??true ;



  Map<int,bool>favorites={};


  List<Widget> bottomScreens=[
    const ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex=index;
    emit(ShopChangeBottomNavState());

  }
  void getHomeData ()
  {
    emit(ShopLoadingHomeDataState());
   DioHelper.getData(
       HOME,
     CacheHelper.getDate('token'),
     {'lang':'en',
     },

   ).then((value)
   {
      homeModel= HomeModel.fromJson(value.data);
      print(homeModel?.status.toString());

      favorites.clear();

      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites??false,
        });

      });

      emit(ShopSuccessHomeDataState());
   }
   ).catchError((onError){
     print (onError);
     emit(ShopErrorHomeDataState());

   });
  }

  void getCategoriesData ()
  {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(
      GET_CATEGORIES,
      CacheHelper.getDate('token'),
      {'lang':'en',
      },

    ).then((value)
    {
      categoriesModel= CategoriesModel.fromJson(value.data);
      print(categoriesModel?.status.toString());
      emit(ShopSuccessCategoriesDataState());
    }
    ).catchError((onError){
      print (onError);
      emit(ShopErrorCategoriesDataState());

    });
  }

  void favoritesChange({
    required int id ,
})
  {
    DioHelper.postDate(
      url: FAVORITES,
      data: {
        'product_id':id,
      },
      token: CacheHelper.getDate('token'),

    ).then((value) {
      favorites[id]=(!favorites[id]!);

      emit(ShopFavoritesChangeState());
      if (favorites[id]!)
      {
        showToast('added to favorites');
      }
      else
      {
        showToast('removed from favorites');
      }
    }).catchError((error){

    });
  }

  void getFavorites ()
  {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(
      FAVORITES,
      CacheHelper.getDate('token'),
      {'lang':'en',
      },
    ).then((value)
     {
       print(value.data);
      favoritesModel=  FavoritesModel.fromJson((value.data));
      print(favoritesModel?.status.toString());
      emit(ShopSuccessFavoritesDataState());
      if(favoritesModel?.status??false)print('daret ya seya3');

    }
    ).catchError((onError){
      print (onError);
      emit(ShopErrorFavoritesDataState());

    });
  }


  void getUserData ()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      PROFILE,
      CacheHelper.getDate('token'),
      {'lang':'en',
      },

    ).then((value)
    {
      shopLoginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }
    ).catchError((onError){
      print (onError);
      emit(ShopErrorUserDataState());

    });
  }


  void userLogout(
      ){
    emit(ShopLogoutLoadingState());
    DioHelper.postDate(
      url: LOGOUT,
      data: {

      },
      token: CacheHelper.getDate('token'),


    ).then((value) {

      CacheHelper.removeData(key: 'token');
      emit(ShopLogoutSuccessState());
      showToast('Logout successfully');
    }).catchError((error){
      emit(ShopLogoutErrorState());
    });

  }

  void userUpdate({
    required String name,
    required String phone,
    required String email,
}){
    emit(ShopUserDataUpdateLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: CacheHelper.getDate('token'),
        data: {
          'name':name,
          'phone':phone,
          'email':email,
        }).then((value) {
          if (value.data['status']==true)
            {
              shopLoginModel=ShopLoginModel.fromJson(value.data);
              print('shagal');
            }
          showToast(value.data['message']);
          emit(ShopUserDataUpdateSuccessState());
          showToast(value.data['message']);
    }).catchError((onError){
      emit(ShopUserDataUpdateErrorState());
      print(onError.toString());
      print('baazeet');
      
    });
  }
  
void edit({
    required String name,

  required String phone,
  required String email,
})
{
  emit(ShopDataEditState());

  if (readOnly==false)
    {
      print ('a7aaaaaaaaa');
      userUpdate(name: name, phone: phone, email: email);
    }
  readOnly=!readOnly;
  

}


  void search(
      {
        required String text,
      }){
    searchModel=null;
    emit(ShopSearchLoadingState());
    DioHelper.postDate(
      url: SEARCH,
      data: {
        "text":text,
      },
      token: CacheHelper.getDate('token'),


    ).then((value) {

        searchModel=SearchModel.fromJson(value.data);
        print('daret ya seya333');
      emit(ShopSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState());
    });

  }

  void changeAppTheme()
  {
    isDarkTheme= !isDarkTheme;

    CacheHelper.putData( key: 'isDark',value: isDarkTheme,).then((value) =>emit(AppChangeThemeState()));

  }


}