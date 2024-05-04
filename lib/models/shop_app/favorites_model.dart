class FavoritesModel{
  FavoritesModel();
  bool? status ;
  String? message;
   FavoritesModelData data=FavoritesModelData();
  FavoritesModel.fromJson(Map<String,dynamic>?json)
  {
      status=json?['status'];
      message=json?['message'];
      data=FavoritesModelData.fromJson(json?['data']);
  }
}
class FavoritesModelData{
  FavoritesModelData();
  int? currentPage;
   FavoritesModelDataData data=FavoritesModelDataData();
   FavoritesModelData.fromJson(Map<String,dynamic>?json)
  {
    currentPage=json?['current_page'];
    data=FavoritesModelDataData.formJson(json?['data']);
  }

}

class FavoritesModelDataData{
  FavoritesModelDataData();
  int ?id;
  List<FavoritesModelDataDataProduct> products=[];
  FavoritesModelDataData.formJson(List<dynamic>?p)
  {
    p?.forEach((element) {
      products.add(
          FavoritesModelDataDataProduct.formJson(element['product']),
      );
    });

  }


}
class FavoritesModelDataDataProduct{
  FavoritesModelDataDataProduct();
  int? id;
  int?price;
  int ?oldPrice;
  int ?discount;
  String? image;
  String ?name;
  String ? description;
  FavoritesModelDataDataProduct.formJson(Map<String,dynamic>?json)
  {
    id=json?['id'];
    price=json?['price'].round();
    oldPrice=json?['old_price'].round();
    discount=json?['discount'].round();
    image=json?['image'];
    name=json?['name'];
    description=json?['description'];
  }

}