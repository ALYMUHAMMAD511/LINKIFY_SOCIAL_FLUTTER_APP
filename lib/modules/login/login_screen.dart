import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/modules/login/login_cubit/cubit.dart';
import 'package:social_app/modules/login/login_cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var formKey = GlobalKey <FormState> ();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);
    return Scaffold(
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
                    'LOGIN',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Login now to browse our hot offers',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
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
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(
                    height: 17.0,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    suffixIcon: LoginCubit.get(context).suffix,
                    onFieldSubmitted: (value)
                    {
                      if (formKey.currentState!.validate())
                      {
                        LoginCubit.get(context).userLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                    isPassword: LoginCubit.get(context).isPasswordShown,
                    suffixPressed: ()
                    {
                      LoginCubit.get(context).changePasswordVisibility();
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
                    height: 20.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState,
                    builder: (context) => defaultButton(
                      onPressed: ()
                      {
                        if (formKey.currentState!.validate())
                        {
                          LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text
                          );
                        }
                      },
                      text: 'login',
                      isUpperCase: true,
                    ),
                    fallback: (context) => const Center(child: CircularProgressIndicator()),
                  ),
                  const SizedBox(
                    height: 17.0,
                  ),
                  Row(
                    children:
                    [
                      const Text(
                        'Don\'t have an Account?',
                      ),
                      defaultTextButton(
                        onPressed: ()
                        {
                          navigateTo(context, RegisterScreen());
                        },
                        text: 'register',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
