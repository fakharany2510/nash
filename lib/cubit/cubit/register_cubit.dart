import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nash2en_masr/config/paths.dart';
import 'package:nash2en_masr/cubit/states/register_states.dart';
import 'package:nash2en_masr/models/login_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);


  void userRegister({
  required String userName,
    required String email,
    required String password,
    required String phone
}){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
      createNewUser(
        userName: userName,
        email: email,
        password: password,
        phone: phone,
        uid: value.user!.uid
      );
          emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState());
    });
  }

  void createNewUser({
    required String uid,
    required String userName,
    required String email,
    required String password,
    required String phone
}){
    emit(CreateUserLoadingState());
    UserModel model=UserModel(
      email: email,
      Phone: phone,
      userId: uid,
      userName: userName
    );
    FirebaseFirestore.instance.collection(Paths.usersPath)
        .doc(uid)
        .set(model.toMap())
        .then((value){
          emit(CreateUserSuccessState());
    })
    .catchError((error){
      emit(CreateUserErrorState());
    });
  }
}