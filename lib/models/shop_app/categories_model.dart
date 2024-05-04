class CategoriesModel{
  CategoriesModel();
bool? status;
String? message;
CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic>?json)
  {
    status=json?['status'];
    message=json?['message'];
    data=CategoriesDataModel.fromJson(json?['data']);
  }
}
class CategoriesDataModel{
  CategoriesDataModel();
  int?currentPage;
  List<CategoriesDataDataModel>data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic>?json)
  {
    currentPage=json?['current_page'];
    json?['data'].forEach((element)
    {
      data.add(CategoriesDataDataModel.fromJson(element));
    });
  }

}

class CategoriesDataDataModel{
  CategoriesDataDataModel();
  int ? id;
  String?name;
  String?image;

  CategoriesDataDataModel.fromJson(Map<String,dynamic>?json)
  {
    id=json?['id'];
    name=json?['name'];
    image=json?['image'];
  }
}