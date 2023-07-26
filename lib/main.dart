import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'cubit/cubit.dart';

Future <void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool defaultMode = false;
  late bool? isDark =  CacheHelper.getBoolean(key: 'isDark');
  late Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (kDebugMode)
  {
    print(uId);
  }

  if (uId != null)
    {
      widget = const SocialLayout();
    }
  else
    {
      widget = LoginScreen();
    }

  runApp(MyApp(
    isDark: isDark ?? defaultMode,
    startWidget : widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  const MyApp({super.key, required this.startWidget, required this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts()..getAllUsers()..changeThemeMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: SocialCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: startWidget,
        ),
      ),
    );
  }
}