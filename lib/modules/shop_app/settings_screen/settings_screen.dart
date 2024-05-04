// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/cubit/states.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/components/components.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void initState() {
    super.initState();
    ShopCubit.get(context).getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        print(state.toString());
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.shopLoginModel?.data == null,
          builder: (context) => Center(child: CircularProgressIndicator()),
          fallback: (context) {
            var nameController =
                TextEditingController(text: cubit.shopLoginModel!.data!.name);
            var phoneController =
                TextEditingController(text: cubit.shopLoginModel!.data!.phone);
            var emailController =
                TextEditingController(text: cubit.shopLoginModel!.data!.email);
            var passwordController = TextEditingController();
            var formKey = GlobalKey<FormState>();

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(cubit.shopLoginModel!.data!.image!),
                        radius: 40,
                        backgroundColor: Colors.grey,
                        onBackgroundImageError: (exception, stackTrace) =>
                            CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextFeild(
                        controller: nameController,
                        prefix: Icons.person_outline,
                        label: 'name',
                        readOnly: ShopCubit.get(context).readOnly,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextFeild(
                        controller: phoneController,
                        prefix: Icons.phone_outlined,
                        label: 'phone',
                        type: TextInputType.phone,
                        readOnly: ShopCubit.get(context).readOnly,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your phone';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextFeild(
                        controller: emailController,
                        prefix: Icons.email_outlined,
                        label: 'email',
                        readOnly: ShopCubit.get(context).readOnly,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ConditionalBuilder(
                          condition: state is ShopUserDataUpdateLoadingState,
                          builder: (context) => CircularProgressIndicator(),
                          fallback: (context) => FloatingActionButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).edit(
                                  email: emailController.text.toString(),
                                  name: nameController.text.toString(),
                                  phone: phoneController.text.toString(),
                                );
                              }
                            },
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            child: ShopCubit.get(context).readOnly == true
                                ? Icon(Icons.edit_outlined)
                                : Icon(
                                    Icons.done,
                                    size: 30,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
