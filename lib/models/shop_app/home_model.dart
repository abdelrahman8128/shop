class HomeModel {
HomeModel();
   bool status=false;
  String? message;
   HomeDataModel data=HomeDataModel();
  HomeModel.fromJson(Map<String,dynamic>?json)
  {
    status=json?['status'];
    message=json?['message'];
    data=HomeDataModel.fromJson(json?['data']);
  }
}
class HomeDataModel {
  HomeDataModel();
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> ?json)
  {
    json?['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });

    json?['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}
class BannerModel{
  BannerModel();
  var id;
  String? image;
  String? category;
  String? product;

  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id =json['id'];
    image=json['image'];
    category=json['category'];
    product=json['product'];
  }
}
class ProductModel{
  ProductModel();
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String?image=null;
  String?name;
  String?description;
  List<dynamic>images=[];
  bool? inFavorites;
  bool? inCart;
  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price =json['price'];
     oldPrice=json['old_price'];
     discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    images=json['images'];
     inFavorites=json['in_favorites'];
     inCart=json['in_cart'];
  }
}