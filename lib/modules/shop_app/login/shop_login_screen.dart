// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/layout/shop_app/shop_layout.dart';
import 'package:p4all/modules/shop_app/login/cubit/states.dart';
import 'package:p4all/shared/network/local/cache_helper.dart';

import '../../../shared/components/components.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';



class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (BuildContext context, ShopLoginStates state) {
          print(state.toString());
          if (state is ShopLoginSuccessState)
            {
              if (state.loginModel.status ==true )
                {
                  print (state.loginModel.data!.token);
                  CacheHelper.putData(key: 'token', value: state.loginModel.data!.token);
                  showToast(state.loginModel.message!);
                  navigateAndFinish(context, ShopLayout());
                }
              else
                {
                  showToast(state.loginModel.message!);

                }
            }
          else if (state is shopLogout)
            {
              showToast(state.logout['message']);
            }
        },

        builder: (BuildContext context, ShopLoginStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        DefaultTextFeild(
                          controller: emailController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultTextFeild(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          obscure: ShopLoginCubit.get(context).isPassword,
                          suffix: IconButton(
                              onPressed: () => ShopLoginCubit.get(context).changePasswordVisibility(),
                              icon: Icon(ShopLoginCubit.get(context).passwordIcon),
                          )
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition:state is ShopLoginLoadingState ,
                          builder:(context) =>  CircularProgressIndicator(color: Colors.deepOrange,) ,
                          fallback: (context) => DefaultButton(
                            text: 'LOGIN',
                            function: () {
                              if (formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have and account?',
                              style: TextStyle(fontSize: 14),

                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                child: Text('Register')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
