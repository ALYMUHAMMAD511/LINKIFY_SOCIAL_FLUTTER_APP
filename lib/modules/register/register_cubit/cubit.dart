import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';


class RegisterCubit extends Cubit <RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid,
      );
      if (kDebugMode)
      {
        print(value.user!.email);
        print(value.user!.uid);
      }
    }).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://img.freepik.com/free-photo/carefree-joyful-handsome-afro-american-man-with-bushy-hairstyle_273609-14083.jpg?w=900&t=st=1686838506~exp=1686839106~hmac=3a52c2d1354134fd0073268b8229b31410a859167153663f4cfd02c85b8f47b5',
      cover: 'https://img.freepik.com/free-photo/carefree-joyful-handsome-afro-american-man-with-bushy-hairstyle_273609-14083.jpg?w=900&t=st=1686838506~exp=1686839106~hmac=3a52c2d1354134fd0073268b8229b31410a859167153663f4cfd02c85b8f47b5',
      bio: 'Write your Biography ...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap()).then((value) {
          emit(CreateUserSuccessState());
    }).catchError((error){
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}