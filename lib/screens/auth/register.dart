import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nana_alert/services/auth_service.dart';
import 'package:nana_alert/utils/helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final formButtonTextStyle =
      const TextStyle(fontFamily: "Poppins", fontSize: 15);

  final buttonBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
  );

  @override
  Widget build(BuildContext context) {
    final loginCallback =
        ModalRoute.of(context)!.settings.arguments as void Function();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create an Account",
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
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
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
                        !Helper.isValidPassword(_passwordController.text)) {
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
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !Helper.isValidPassword(
                            _confirmPasswordController.text) ||
                        _confirmPasswordController.text !=
                            _passwordController.text) {
                      return "Password does not match!";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration:
                      const InputDecoration(labelText: "Confirm Password"),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "*password must be 8+ characters\n*at least one number\n*one uppercase letter\n*one lowercase letter",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        String content;
                        bool isSuccessful = true;

                        try {
                          UserCredential? userCredential = await AuthService()
                              .createAccountWithEmail(_emailController.text,
                                  _passwordController.text);
                          content = "Success!";
                        } on FirebaseAuthException catch (error) {
                          switch (error.code) {
                            case "EMAIL-ALREADY-IN-USE":
                              content =
                                  "Your email is already in use by another account.";
                              break;
                            case "INVALID-EMAIL":
                              content = "Your email is invalid.";
                              break;
                            case "WEAK-PASSWORD":
                              content = "Your password is weak.";
                              break;
                            default:
                              content = "An unknown error has occurred";
                              break;
                          }
                          isSuccessful = false;
                        } catch (otherError) {
                          print("GENERIC ERROR: $otherError");
                          content = "An unknown error has occurred";
                          isSuccessful = false;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
