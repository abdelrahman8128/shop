import 'home_model.dart';

class SearchModel{

  SearchModel();
  bool ?status;
  String? message;
  List<ProductModel> products = [];
  SearchModel.fromJson(Map<String,dynamic>?json)
  {
    status=json?['status'];
    message=json?['message'];
    json=json?['data'];
    json?['data'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });

  }
}