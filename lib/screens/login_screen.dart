import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nash2en_masr/config/theme/app_theme.dart';
import 'package:nash2en_masr/cubit/cubit/login_cubit.dart';
import 'package:nash2en_masr/cubit/states/login_states.dart';
import 'package:nash2en_masr/localization/localization_methods.dart';
import 'package:nash2en_masr/network/local/shared_preference.dart';
import 'package:nash2en_masr/screens/payment.dart';
import 'package:nash2en_masr/utils/app_color.dart';
import 'package:nash2en_masr/utils/app_strings.dart';

import '../localization/set_localization.dart';
import '../widgets/shared_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer< LoginCubit , LoginStates >(builder: (context , state){
      return Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
                      }
                      , child: Text('pay')),
                  Image(image: AssetImage('assets/images/smallappicon.png'),width: 300,height: 300),
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
                      errorMessage:getTranslated(context, "please enter your password")!,
                      inputType: TextInputType.visiblePassword,
                      labelText: getTranslated(context, "password")!,
                      prefixIcon: Icons.password
                  ),
                  SizedBox(height: 20,),
                  defaultButton(
                    buttonText: SetLocalization.of(context)!.getTranslateValue('LOGIN')!,
                    buttonColor: AppColor.primaryColor,
                    size: size,
                    function: (){
                      if(formKey.currentState!.validate()){
                        LoginCubit.get(context).userLogin(email: email.text, password: password.text);
                      }
                    }
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated(context, "Dont Have Account ?")!,style:const TextStyle(
                          fontFamily: AppStrings.appFont,
                          fontSize: 18,
                          color: Colors.black
                      ),),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child:  Text(getTranslated(context, "register")!,style: TextStyle(
                            color: AppColor.primaryColor,
                            fontFamily: AppStrings.appFont,
                            fontSize: 18
                        ),
                        ),
                      )
                    ],
                  ),
                  //SizedBox(height: 20,),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, 'reset');
                  //   },
                  //   child:  Text('Forget Password ? ',style: TextStyle(
                  //       color: AppColor.primaryColor,
                  //       fontFamily: AppStrings.appFont,
                  //       fontSize: 18
                  //   ),
                  //   ),
                  // ),
                  SizedBox(height: 20,),
                  defaultSocialMediaButton(
                    function: (){},
                    size:size,
                    buttonColor: AppColor.primaryColor,
                    buttonText: getTranslated(context, "Login With Facebook")!,
                    imagePath: 'assets/images/face.png'
                  ),
                  SizedBox(height: 20,),
                  defaultSocialMediaButton(
                      function: (){
                        LoginCubit.get(context).loginWithGoogle();
                      },
                      size:size,
                      buttonColor: AppColor.primaryColor,
                      buttonText: getTranslated(context, "Login With Google")!,
                      imagePath: 'assets/images/google1.png'
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context , state){
      if(state is LoginSuccessState){
        CacheHelper.saveData(key:'userId' , value: state.uId).then((value){
          Fluttertoast.showToast(
            msg:getTranslated(context, "welcome")!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18.0,
          );
          Navigator.pushNamed(context, 'home');
        }).catchError((error){
          print('error from saving user id to shared ${error.toString()}');
        });
      } else if(state is GoogleLoginSuccessState){
        CacheHelper.saveData(key:'userId' , value: state.uId).then((value){
          Fluttertoast.showToast(
            msg:getTranslated(context, "welcome")!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18.0,
          );
          Navigator.pushNamed(context, 'home');
        }).catchError((error){
          print('error from saving user google id to shared ${error.toString()}');
        });
      }
    });
  }
}
