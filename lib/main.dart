import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nash2en_masr/cubit/cubit/login_cubit.dart';
import 'package:nash2en_masr/cubit/cubit/register_cubit.dart';
import 'package:nash2en_masr/network/local/shared_preference.dart';
import 'package:nash2en_masr/pages/home_page.dart';
import 'package:nash2en_masr/screens/login_screen.dart';
import 'package:nash2en_masr/screens/register_screen.dart';
import 'package:nash2en_masr/screens/reset_password.dart';
import 'package:nash2en_masr/widgets/splash_screen_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_observer.dart';
import 'localization/set_localization.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  dynamic userId = CacheHelper.getDatat(key: 'userId');
  Widget widget;
  if(userId !=null){
    widget = HomePage();
  }else{
    widget = SplashScreen();
  }
  Bloc.observer = MyBlocObserver();
  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
       BlocProvider(create:(context)=>LoginCubit()),
      BlocProvider(create: (context)=>RegisterCubit())
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nash2en Masr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: const [
        Locale('en' , 'US'),
        Locale('ar' , 'EG'),
      ],
      localizationsDelegates:const [
        SetLocalization.localizationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,

      ],
      localeResolutionCallback: (deviceLocal, supportedLocales) {
        for (var local in supportedLocales) {
          if (local.languageCode == deviceLocal!.languageCode &&
              local.countryCode == deviceLocal.countryCode) {
            return deviceLocal;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: '/',
      routes: {
        '/' :(context)=>startWidget,
        'login':(context)=>LoginScreen(),
        'register':(context)=>RegisterScreen(),
        'home':(context)=>HomePage(),
        'reset':(context)=>ResetPassword(),
      },
    ),);
  }
}

