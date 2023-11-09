import 'package:flutter/material.dart';
import 'package:nana_alert/screens/auth/login.dart';
import 'package:nana_alert/shared/provider/settings_data.dart';
import 'package:provider/provider.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay({super.key, required this.rebuildCallback});

  final void Function() rebuildCallback;

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  bool _isEmergencyCentered = false;

  /// This is the function that toggles the setting for "Center Emergency Button." It sends an update to the provider as well as the widget and its parent.
  void toggleIsEmergencyCentered() {
    Provider.of<SettingsData>(context, listen: false).toggleEmergencyCentered();
    setState(() {
      widget.rebuildCallback();
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: Image.network(
                  'https://i.pinimg.com/564x/56/c1/3d/56c13d61eb73d60d21cbb90784fdf9e7.jpg',
                ).image,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text('Hi!'),
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
            SettingListTile(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              icon: const Icon(Icons.account_circle_outlined),
              label: "Login / Register",
            ),
            SettingListTile(
              onTap: () => {},
              icon: const Icon(Icons.account_circle),
              label: "Edit Personal Information",
            ),
            SettingListTile(
              onTap: () => {},
              icon: const Icon(Icons.remove_circle_outline_sharp),
              label: "Reset Planner",
            ),
            SettingListTile(
              onTap: () => {},
              icon: const Icon(Icons.cabin_rounded),
              label: "About the Developer",
            ),
            SettingListTile(
              onTap: () => {},
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
