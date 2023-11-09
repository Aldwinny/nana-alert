import 'package:flutter/material.dart';
import 'package:nana_alert/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            IconButton(
              onPressed: () => AuthService().signInWithGoogle(),
              icon: Icon(
                Icons.golf_course_rounded,
                color: Colors.black,
              ),
              color: Colors.amber,
            ),
          ]),
        ),
      ),
    );
  }
}
