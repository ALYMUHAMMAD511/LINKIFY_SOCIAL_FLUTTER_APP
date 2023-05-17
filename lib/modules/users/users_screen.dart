import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Text(
        'Users',
        style: Theme.of(context).textTheme.titleMedium!
    );
  }
}