import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:toast/toast.dart';
import 'cubit/cubit.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  if (kDebugMode)
  {
    print(message.data.toString());
  }
  Toast.show('onMessageBackground Notification Sent', backgroundColor: Colors.green, duration: Toast.lengthLong);
}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  var token = await FirebaseMessaging.instance.getToken();
  if (kDebugMode)
  {
    print(token);
  }
  //Foreground FCM
  FirebaseMessaging.onMessage.listen((event)
  {
    if (kDebugMode)
    {
      print(event.data.toString());
    }
    Toast.show('onMessage Notification Sent', backgroundColor: Colors.green, duration: Toast.lengthLong);
  });

  // On Clicking on the Notification to Open the App
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    if (kDebugMode)
    {
      print(event.data.toString());
    }
    Toast.show('onMessageOpenedApp Notification Sent', backgroundColor: Colors.green, duration: Toast.lengthLong);
  });

  // Background FCM
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
    startWidget : widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  const MyApp({super.key, required this.startWidget, required this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts()..changeThemeMode(fromShared: isDark),
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