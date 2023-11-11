import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nana_alert/screens/auth/login.dart';
import 'package:nana_alert/screens/others/about.dart';
import 'package:nana_alert/services/auth_service.dart';
import 'package:nana_alert/shared/provider/settings_data.dart';
import 'package:provider/provider.dart';
import 'package:nana_alert/utils/helper.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay({super.key, required this.rebuildCallback});

  final void Function() rebuildCallback;

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  bool _isEmergencyCentered = false;
  bool _isLoggedIn = false;

  /// This is the function that toggles the setting for "Center Emergency Button." It sends an update to the provider as well as the widget and its parent.
  void toggleIsEmergencyCentered() {
    Provider.of<SettingsData>(context, listen: false).toggleEmergencyCentered();
    setState(() {
      widget.rebuildCallback();
    });
  }

  void checkLoggedInState() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isEmergencyCentered =
        Provider.of<SettingsData>(context).isEmergencyCentered;
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        Helper.getAssetName(
                            "mother-and-child-low.jpg", "images"),
                      ).image)),
            ),
            Padding(
              padding: EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nana Alert',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.deepPurple[800],
                    ),
                  ),
                  Text("Version 1.0.0")
                ],
              ),
            ),
            const Divider(),
            SettingListTile(
              title: Row(children: <Widget>[
                const Expanded(child: Text("Center Emergency Button")),
                Switch(
                  onChanged: (v) {
                    toggleIsEmergencyCentered();
                  },
                  value: _isEmergencyCentered,
                )
              ]),
            ),
            const Divider(),
            if (!_isLoggedIn)
              SettingListTile(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.routeName,
                      arguments: () => checkLoggedInState());
                },
                icon: const Icon(Icons.account_circle_outlined),
                label: "Login / Register",
              ),
            SettingListTile(
              // REMOVE ALL RECORDS IN FIREBASE
              onTap: () => {},
              icon: const Icon(Icons.remove_circle_outline_sharp),
              label: "Reset Planner",
            ),
            SettingListTile(
              onTap: () => Navigator.pushNamed(context, AboutScreen.routename),
              icon: const Icon(Icons.cabin_rounded),
              label: "About the Developer",
            ),
            if (_isLoggedIn)
              SettingListTile(
                onTap: () => AuthService()
                    .signOut()
                    .then((_) => {print(FirebaseAuth.instance.currentUser)}),
                icon: const Icon(Icons.power_settings_new),
                label: "Logout",
              )
          ],
        ),
      ),
    );
  }
}

class SettingListTile extends StatelessWidget {
  const SettingListTile(
      {super.key, this.icon, this.label, this.title, this.onTap});

  final Widget? icon;
  final String? label;
  final Widget? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (label != null && title != null) {
      throw AssertionError(
          "label != null && title != null. Remove either label or either from the parameter of this Widget.");
    }

    return ListTile(
      onTap: onTap,
      leading: icon,
      title: label != null ? Text(label!) : title,
    );
  }
}
