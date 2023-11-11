import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nana_alert/screens/home.dart';
import 'package:nana_alert/utils/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _timer = Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SizedBox(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: const Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Nana Alert',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 60,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
