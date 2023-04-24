import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';


class RegisterCubit extends Cubit <RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  // late LoginModel loginModel;
  //
  // void userRegister({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  // }) {
  //   emit(RegisterLoadingState());
  //   DioHelper.postData(
  //       url: REGISTER,
  //       data: {
  //         'email': email,
  //         'password': password,
  //         'name' : name,
  //         'phone': phone,
  //       }).then((value) {
  //     if (kDebugMode) {
  //       print(value.data);
  //       loginModel = LoginModel.fromJson(value.data);
  //       emit(RegisterSuccessState(loginModel));
  //     }
  //   }).catchError((error) {
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //     emit(RegisterErrorState(error));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix =
    isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}