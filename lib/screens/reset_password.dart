import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nash2en_masr/cubit/cubit/login_cubit.dart';
import 'package:nash2en_masr/cubit/states/login_states.dart';
import 'package:nash2en_masr/utils/app_color.dart';
import 'package:nash2en_masr/utils/app_strings.dart';

import '../widgets/shared_widgets.dart';
class ResetPassword extends StatelessWidget {
   var formKey=GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  void dispose(){
    email.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit,LoginStates>(
        builder: (context , state){
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                child: Form(
                  key:formKey ,
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/images/smallappicon.png'),width: 300,height: 300),
                      Text('Reset Password',
                        style: TextStyle(
                          fontFamily: AppStrings.appFont,
                          color: AppColor.hintColorColor,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 20,),
                      textFormFieldWidget(
                          context: context,
                          controller: email,
                          errorMessage: 'please enter your email',
                          inputType: TextInputType.emailAddress,
                          labelText: 'E-Mail',
                          prefixIcon: Icons.password
                      ),
                      SizedBox(height: 25,),
                      defaultButton(
                          buttonText: 'Reset',
                          buttonColor: AppColor.primaryColor,
                          size: size,
                          function: (){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).resetPassword(email.text);
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
        listener: (context , state){});
  }
}
