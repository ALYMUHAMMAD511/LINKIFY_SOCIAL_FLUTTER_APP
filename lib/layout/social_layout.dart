import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:toast/toast.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);

    return BlocConsumer <SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('News Feed'),
        ),
        body: ConditionalBuilder(
          condition: SocialCubit.get(context).userModel != null,
          builder: (context)
          {
            var model = SocialCubit.get(context).userModel;
            return Column(
              children:
              [
                if (!FirebaseAuth.instance.currentUser!.emailVerified)
                  Container(
                  color: Colors.amber.withOpacity(0.6),
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(width: 15.0,),
                        const Expanded(
                            child: Text('Please, Verify your Email')),
                        const SizedBox(width: 20.0,),
                        defaultTextButton(
                          onPressed: ()
                          {
                            FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value)
                            {
                              Toast.show('Check your Mail', backgroundColor: Colors.green, gravity: Toast.bottom);
                            }).catchError((error)
                            {

                            });
                          },
                          text: 'Send',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),

        ),
      ),
    );
  }
}
