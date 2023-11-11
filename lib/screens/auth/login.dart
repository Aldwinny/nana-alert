import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formButtonTextStyle =
      const TextStyle(fontFamily: "Poppins", fontSize: 15);

  final buttonBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginCallback =
        ModalRoute.of(context)!.settings.arguments as void Function();

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
                  controller: _emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !Helper.isValidEmail(value)) {
                      return "Please a valid email";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !Helper.isValidPassword(value)) {
                      return "Please enter a valid password";
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
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        String content;
                        bool isSuccessful = false;

                        try {
                          UserCredential? userCredential = await AuthService()
                              .signInWithEmail(_emailController.text,
                                  _passwordController.text);

                          print(userCredential);
                          content = "Success!";
                          isSuccessful = true;
                        } on FirebaseAuthException catch (error) {
                          switch (error.code) {
                            case "INVALID_LOGIN_CREDENTIALS":
                              content = "Invalid Login Credentials.";
                              break;
                            default:
                              content = "An unknown error has occurred";
                          }
                        } catch (e) {
                          print('GENERIC_ERROR: $e');
                          content = "An unknown error has occurred";
                        }
                        if (context.mounted) {
                          SnackBar sb = SnackBar(
                            duration: const Duration(seconds: 1),
                            content: WillPopScope(
                              child: Text(content),
                              onWillPop: () async {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();

                                return true;
                              },
                            ),
                          );

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                sb,
                              )
                              .closed
                              .then(
                            (reason) {
                              if (isSuccessful) {
                                loginCallback();
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                              }
                            },
                          );
                        }
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
                              onTap: () async {
                                String content;
                                bool isSuccessful = false;
                                try {
                                  UserCredential? userCredential =
                                      await AuthService().signInWithGoogle();

                                  print(userCredential);
                                  content = "Success!";
                                  isSuccessful = true;
                                } catch (error) {
                                  content =
                                      "An unkown error has occurred. Please try again.";
                                }
                                if (context.mounted) {
                                  SnackBar sb = SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: WillPopScope(
                                      child: Text(content),
                                      onWillPop: () async {
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();

                                        return true;
                                      },
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(sb)
                                      .closed
                                      .then((reason) {
                                    if (isSuccessful) {
                                      loginCallback();

                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                    }
                                  });
                                }
                              },
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
                    onPressed: () => Navigator.pushNamed(
                        context, RegisterScreen.routeName,
                        arguments: loginCallback),
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
