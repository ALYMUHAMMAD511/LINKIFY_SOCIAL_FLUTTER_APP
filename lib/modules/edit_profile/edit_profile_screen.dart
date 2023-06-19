import 'package:flutter/material.dart';
import 'package:social_app/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Edit Profile',
        actions: [
          defaultTextButton(
          onPressed: (){},
          text: 'Update',
          ),
      ],
      ),
    );
  }
}