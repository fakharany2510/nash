import 'package:nash2en_masr/models/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates{}

class GoogleLoginLoadingState extends LoginStates{}
class GoogleLoginSuccessState extends LoginStates{
  final String uId;
  GoogleLoginSuccessState(this.uId);
}
class GoogleLoginErrorState extends LoginStates{}

class ResetLoadingState extends LoginStates{}
class ResetLoginSuccessState extends LoginStates{}
class ResetLoginErrorState extends LoginStates{}