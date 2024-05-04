import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p4all/layout/shop_app/cubit/cubit.dart';
import 'package:p4all/models/shop_app/categories_model.dart';
import 'package:p4all/models/shop_app/favorites_model.dart';
import '../../models/shop_app/home_model.dart';
import '../styles/colors.dart';

Widget DefaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  required String text,
  required Function function,
  double radius = 10,
}) {
  return Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: MaterialButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget DefaultTextFeild({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator validate,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required String label,
  IconData? prefix,
  Widget? suffix,
  bool obscure = false,
  bool isEnabled = true,
  bool show = false,
  Color color = Colors.white,
  bool readOnly=false,
}) =>
    TextFormField(
      onTap: () {
        onTap!();
      },
      onChanged: (value) {
        onChange!(value);
      },
      enabled: isEnabled,
      controller: controller,
      validator: validate,
      keyboardType: type,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      readOnly:readOnly,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),

        prefixIcon: Icon(prefix),
        suffixIcon: suffix,

      ),
    );


Widget buildBannerItem(BannerModel model) => Container(
      child: ConditionalBuilder(
        condition: model.image == null,
        builder: (context) => const CircularProgressIndicator(),
        fallback: (context) => Image(
          image: NetworkImage('${model.image}'),
          width: double.infinity,
          height: 200.0,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },

        ),
      ),
    );

Widget buildGridProductItem(ProductModel model) => Container(
      child: ConditionalBuilder(
        condition: model.image != null,
        builder: (context) => Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(
                    height: 200,
                    child: Image(
                      image: NetworkImage(model.image!),
                      width: double.infinity,
                      height: 200.0,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 65,
                    height: 20,
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                            backgroundColor: Colors.deepOrange,
                            color: Colors.white,
                            fontSize: 11),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price} EGP',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${model.oldPrice ?? ''}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[300],
                              decoration: TextDecoration.lineThrough),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context).favoritesChange(id: model.id!);
                            },
                            icon: Icon(
                              Icons.favorite_outline,
                              size: 20,
                              color: ShopCubit.get(context).favorites[model.id]!?Colors.redAccent:Colors.grey[500],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        fallback: (context) => const CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );

Widget buildGridCategoryItem(CategoriesDataDataModel model) => Container(
      child: ConditionalBuilder(
        condition: model.image != null,
        builder: (context) => Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}'),
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )

                ],
          ),
        ),
        fallback: (context) => const CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );

Widget buildGridFavoritesItem(FavoritesModelDataDataProduct model,context) => Container(
  child: ConditionalBuilder(
    condition: model.image != null,
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 120,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 120,
            child: Image(
              image: NetworkImage(model.image!),
              height: 120,
              width: 120,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(

                  child: Text('${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                    ),

                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price} EGP',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${model.oldPrice ?? ''}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[300],
                          decoration: TextDecoration.lineThrough),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).favoritesChange(id: model.id!);
                        },
                        icon: Icon(
                          Icons.favorite_outline,
                          size: 20,
                          color: ShopCubit.get(context).favorites[model.id]!?Colors.redAccent:Colors.grey[500],
                        ))
                  ],
                ),
              ],
            ),
          ),


        ],
      ),
    ),
    fallback: (context) => const CircularProgressIndicator(
      color: Colors.orange,
    ),
  ),
);

// Widget buildProductsItem( context,ProductModel Product)=>Container(
//
//   child: ConditionalBuilder(
//     condition: banner.image !=null,
//     builder: (context) =>  Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Image(
//           image: NetworkImage(banner.image!),
//           height: 250,
//         ),
//       ],
//     ),
//     fallback: (context) => Center(child: CircularProgressIndicator()),
//   ),
//
//
//
// );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast(String text) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
