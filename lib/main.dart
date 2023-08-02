// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mix_tube_application/configs/di.dart';
import 'package:mix_tube_application/configs/routes.dart';
import 'package:mix_tube_application/contants/route_name.dart';
import 'package:mix_tube_application/stores/counter_store/counter_store.dart';
import 'package:mix_tube_application/stores/login_store/login_store.dart';
import 'package:mix_tube_application/stores/task_store/task_store.dart';
import 'package:mix_tube_application/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  setUpDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print(message);
  }

  void checkSignInFirebase() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      print(user);
      if (user == null) {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(RouterName.LOGIN_PAGE, (route) => false);
      } else {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(RouterName.HOME_PAGE, (route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkSignInFirebase();
      setupInteractedMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CounterStore>(create: (_) => getIt.get<CounterStore>()),
        Provider<TaskStore>(create: (_) => getIt.get<TaskStore>()),
        Provider<LoginStore>(create: (_) => getIt.get<LoginStore>()),
      ],
      child: MaterialApp(
        onGenerateRoute: onGenerateRoute,
        title: 'MixTube',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
