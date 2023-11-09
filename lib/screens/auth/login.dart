import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nana_alert/screens/auth/register.dart';
import 'package:nana_alert/services/auth_service.dart';
import 'package:nana_alert/utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final formButtonTextStyle =
      const TextStyle(fontFamily: "Poppins", fontSize: 15);

  final buttonBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.deepPurple[50]),
        ),
        iconTheme: IconThemeData(color: Colors.deepPurple[50]),
        backgroundColor: Colors.deepPurple[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
                  child: Placeholder(
                    fallbackHeight: 100,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                          ),
                        );
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 5.0),
                            child: Text(
                              'Login',
                              style: formButtonTextStyle.copyWith(
                                  color: Colors.deepPurple[50]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Create an account:",
                    style: formButtonTextStyle.copyWith(
                      color: Colors.deepPurple[900],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 212,
                    height: 45,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          bottom: 0.0,
                          child: SvgPicture.asset(
                            Helper.getAssetName(
                                "android_light_sq_ctn.svg", "brand"),
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => print("hello"),
                              splashColor:
                                  Colors.deepPurple[100]!.withAlpha(200),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(212, 50),
                      shape: buttonBorder,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, RegisterScreen.routeName),
                    icon: const Icon(Icons.email),
                    label: Text("Use your own Email",
                        style: formButtonTextStyle.copyWith(fontSize: 14)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
