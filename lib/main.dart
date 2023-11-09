import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nana_alert/shared/provider/settings_data.dart';
import 'package:nana_alert/shared/provider/user_data.dart';
import 'package:provider/provider.dart';
import 'package:nana_alert/screens/auth/login.dart';
import 'package:nana_alert/screens/auth/register.dart';
import 'package:nana_alert/screens/getting_started.dart';
import 'package:nana_alert/screens/home.dart';
import 'package:nana_alert/screens/others/about.dart';
import 'package:nana_alert/screens/splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .whenComplete(() async {
    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Customizations
  Color primaryColor = Colors.deepPurple;
  Color? iconColor = Colors.white;
  double iconSize = 25.0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserData>(create: (_) => UserData()),
        ChangeNotifierProvider<SettingsData>(create: (_) => SettingsData())
      ],
      child: MaterialApp(
        title: 'Nana Alert',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepOrange[400],
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          iconTheme: IconThemeData(
            color: iconColor,
            size: iconSize,
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          // Initial Screens
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          GettingStartedScreen.routeName: (context) =>
              const GettingStartedScreen(),

          // Auth
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),

          // Others
          AboutScreen.routename: (context) => const AboutScreen()
        },
      ),
    );
  }
}
