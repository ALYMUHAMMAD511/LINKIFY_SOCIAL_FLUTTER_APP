import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login_cubit/states.dart';


class LoginCubit extends Cubit <LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  // late LoginModel loginModel;
  //
  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(LoginLoadingState());
  //   DioHelper.postData(
  //       url: LOGIN,
  //       data: {
  //         'email': email,
  //         'password': password,
  //       }).then((value) {
  //     if (kDebugMode) {
  //       print(value.data);
  //       loginModel = LoginModel.fromJson(value.data);
  //       emit(LoginSuccessState(loginModel));
  //     }
  //   }).catchError((error) {
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //     emit(LoginErrorState(error));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix =
    isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeLoginPasswordVisibilityState());
  }
}