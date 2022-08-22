import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nash2en_masr/cubit/cubit/register_cubit.dart';
import 'package:nash2en_masr/cubit/states/register_states.dart';
import 'package:nash2en_masr/localization/localization_methods.dart';

import '../widgets/shared_widgets.dart';
import '../utils/app_color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  var formKey =GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit, RegisterStates>(
        builder: (context, state){
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Container(
                          child: Image(
                              image: AssetImage('assets/images/smallappicon.png'),width: 300,height: 300)),
                      textFormFieldWidget(
                          context: context,
                          controller: name,
                          errorMessage: getTranslated(context, "please enter your Name")!,
                          inputType: TextInputType.name,
                          labelText: getTranslated(context, "name")!,
                          prefixIcon: Icons.person
                      ),
                      SizedBox(height: 35,),
                      textFormFieldWidget(
                          context: context,
                          controller: phone,
                          errorMessage: getTranslated(context, "please enter your Phone Number")!,
                          inputType: TextInputType.name,
                          labelText: getTranslated(context, "phone number")!,
                          prefixIcon: Icons.phone
                      ),
                      SizedBox(height: 35,),
                      textFormFieldWidget(
                          context: context,
                          controller: email,
                          errorMessage: getTranslated(context, "please enter your email")!,
                          inputType: TextInputType.emailAddress,
                          labelText: getTranslated(context, "email")!,
                          prefixIcon: Icons.mail_sharp
                      ),
                      SizedBox(height: 35,),
                      textFormFieldWidget(
                          context: context,
                          controller: password,
                          errorMessage: getTranslated(context, "please enter your password")!,
                          inputType: TextInputType.visiblePassword,
                          labelText: getTranslated(context, "password")!,
                          prefixIcon: Icons.password
                      ),
                      SizedBox(height: 50,),
                      defaultButton(
                          buttonText:getTranslated(context, "register")!,
                          buttonColor: AppColor.primaryColor,
                          size: size,
                          function: (){
                            if(formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister(
                                  userName: name.text,
                                  email: email.text,
                                  password: password.text ,
                                  phone: phone.text
                              );
                            }
                          }

                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener:(context , state){
          if(state is RegisterSuccessState){
            Fluttertoast.showToast(
              msg:getTranslated(context, "account created successfully")!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0,
            );
            Navigator.pushNamed(context, 'home');
          }
        }
        );
  }
}
