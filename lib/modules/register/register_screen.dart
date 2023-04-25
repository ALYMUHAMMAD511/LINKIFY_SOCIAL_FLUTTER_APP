import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit/cubit.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey <FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer <RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          if (state is RegisterSuccessState)
          {
          //   if (state.loginModel.status)
          //   {
          //     CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
          //     {
          //       token = state.loginModel.data!.token;
          //       navigateAndFinish(context, const ShopLayout());
          //     }
          //     );
          //     if (kDebugMode)
          //     {
          //       print(state.loginModel.message);
          //       print(state.loginModel.data!.token);
          //     }
          //     Toast.show(state.loginModel.message, duration: Toast.lengthLong, gravity:  Toast.bottom, backgroundColor: Colors.green);
          //   }
          //   else
          //   {
          //     if (kDebugMode)
          //     {
          //       print(state.loginModel.message);
          //     }
          //     Toast.show(state.loginModel.message, duration: Toast.lengthLong, gravity:  Toast.bottom, backgroundColor: Colors.red);
          //   }
           }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Register now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'Please, Enter your Name';
                          }
                          return null;
                        },
                        labelText: 'Name',
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(
                        height: 17.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'Please, Enter your Email Address';
                          }
                          return null;
                        },
                        labelText: 'Email Address',
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 17.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffixIcon: RegisterCubit.get(context).suffix,
                        onFieldSubmitted: (value) {},
                        isPassword: RegisterCubit.get(context).isPasswordShown,
                        suffixPressed: ()
                        {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        validate: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'Password should not be Empty';
                          }
                          return null;
                        },
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 17.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'Phone Number should not be Empty';
                          }
                          return null;
                        },
                        labelText: 'Phone Number',
                        prefixIcon: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                          onPressed: ()
                          {
                            if (formKey.currentState!.validate())
                            {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',
                          isUpperCase: true,
                        ),
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
