// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/modules/shop_app/login/shop_login_screen.dart';
import 'package:p4all/modules/shop_app/register/cubit/cubit.dart';
import 'package:p4all/modules/shop_app/register/cubit/states.dart';
import 'package:p4all/shared/components/components.dart';


class ShopRegisterScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterCubitStates>(
        listener: (context, state) {

          if (state is ShopRegisterSuccessState)
            {
              if (state.status==true)
                {
                  navigateAndFinish(context, ShopLoginScreen());
                }
            }
          else if (state is ShopRegisterErrorState)
            {
              print(state.error.toString());
            }

        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(title: Text('Register'),),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      DefaultTextFeild(
                        controller: nameController,
                        label: 'name',
                        type: TextInputType.name,
                        validate: ( value) {
                          if (value.isEmpty||value==null)
                          {
                            return'please enter your name';
                          }
                          return null;
                        },
                        prefix: Icons.person_outline,

                      ),
                      SizedBox(height: 15,),
                      DefaultTextFeild(
                        controller: phoneController,
                        label: 'phone',
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value==null||value.isEmpty)
                          {
                            return'please enter your phone';
                          }
                          return null;
                        },
                        prefix: Icons.phone_outlined,

                      ),
                      SizedBox(height: 15,),
                      DefaultTextFeild(
                        controller: emailController,
                        label: 'email',
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value==null||value.isEmpty)
                          {
                            return'please enter your email';
                          }
                          return null;
                        },
                        prefix: Icons.email_outlined,

                      ),
                      SizedBox(height: 15,),
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
                          obscure: ShopRegisterCubit.get(context).isPassword,
                          suffix: IconButton(
                            onPressed: () => ShopRegisterCubit.get(context).changePasswordVisibility(),
                            icon: Icon(ShopRegisterCubit.get(context).passwordIcon),
                          )
                      ),
                      SizedBox(height: 15,),
                      ConditionalBuilder(
                          condition: state is ShopRegisterLoadingState,
                          builder:(context) =>  Center(child: CircularProgressIndicator()),
                          fallback: (context) =>  DefaultButton(text: 'Register',
                              function: (){
                                if (formKey.currentState!.validate())
                                {
                                  ShopRegisterCubit.get(context).Register(
                                    name: nameController.text.toString(),
                                    phone: phoneController.text.toString(),
                                    email: emailController.text.toString(),
                                    password: passwordController.text.toString(),
                                  );

                                }

                              }
                          ),
                      ),


                    ],
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
