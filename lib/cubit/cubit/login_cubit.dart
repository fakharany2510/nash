import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nash2en_masr/cubit/states/login_states.dart';
import 'package:nash2en_masr/models/login_model.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(): super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
 UserModel? model;
  void userLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value){
          emit(LoginSuccessState(value.user!.uid));
          print('--------------------------->${value.user!.email}');

    })
        .catchError((error){
          print('error while login------------>   ${error}');
          emit(LoginErrorState());
    });
  }
  //////////////////////////////////////////////////////////////////////////
GoogleSignIn googleSignIn = GoogleSignIn();
Future<void> loginWithGoogle()async{
  emit(GoogleLoginLoadingState());
    //account
    GoogleSignInAccount? account =  await googleSignIn.signIn();
    //authentication
    GoogleSignInAuthentication authentication = await account!.authentication;
    //cradential
    AuthCredential credential = GoogleAuthProvider.credential(idToken: authentication.idToken,accessToken: authentication.accessToken);
    //user
    User? user =(await FirebaseAuth.instance.signInWithCredential(credential)).user;
    emit(GoogleLoginSuccessState(user!.uid));
    if(user !=null){
      print('user account from google ------> ${user.email}');
    }else{
      print('error');
      emit(GoogleLoginErrorState());
    }

}
//////////////////////////////////////////////////////////////
Future resetPassword(String email)async{
  emit(ResetLoadingState());
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email)
      .then((value){
        emit(ResetLoginSuccessState());
  })
  .catchError((error){
    emit(ResetLoginErrorState());
  });
}
}