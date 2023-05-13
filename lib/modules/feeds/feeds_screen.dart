import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children:
      [
        Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin: const EdgeInsets.all(8.0),
            child: Stack(
              children :
              const [
                Image(
                  image: NetworkImage('https://img.freepik.com/free-photo/social-media-concept-with-smartphone_52683-100042.jpg?w=900&t=st=1683993733~exp=1683994333~hmac=06f38627a284122de3ae8554f36b3aa024f04ef79dc22342f6ebad642fe31179'),
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                ),
                Text('Communicate with Friends'),
              ],
            ),
          ),
      ],
    );
  }
}