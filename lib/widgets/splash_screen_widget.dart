import 'package:flutter/material.dart';
import 'package:nash2en_masr/config/theme/app_theme.dart';
import 'package:nash2en_masr/localization/localization_methods.dart';
import 'package:nash2en_masr/screens/login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:hexcolor/hexcolor.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 50,
      imageSize: 170,
      imageSrc: "assets/images/applogo.jpg",
      text: getTranslated(context, "Nash2en Masr"),
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 35.0,
        fontFamily: 'komax',
      ),
      colors: [
        //HexColor('#FC0712'),
        HexColor('#605f65'),
        HexColor('#ffffff'),

      ],
      backgroundColor:appTheme().primaryColor,
    );
  }
}
