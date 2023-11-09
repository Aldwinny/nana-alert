import 'package:flutter/material.dart';
import 'package:nana_alert/screens/overlays/guide_overlay.dart';
import 'package:nana_alert/screens/overlays/planner_overlay.dart';
import 'package:nana_alert/screens/overlays/settings_overlay.dart';
import 'package:nana_alert/shared/provider/settings_data.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.activeScreen});

  final Widget? activeScreen;
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEmergencyCentered = false;

  int _active = 0;

  // Customization
  final Color? topDownColor = Colors.deepPurple[300];

  // Floating Action Button
  FloatingActionButtonLocation fabLocation =
      FloatingActionButtonLocation.endDocked;

  // Bottom App Bar Stuff
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10);
  final TextStyle labelTextStyle =
      const TextStyle(color: Colors.white, fontSize: 14);

  void reloadState() {
    setState(() {
      _isEmergencyCentered = !_isEmergencyCentered;
    });
    print("Updated!");
  }

  void setActiveScreen(index) {
    setState(() {
      _active = index;
    });
  }

  late final _overlays;

  @override
  void initState() {
    _overlays = [
      const GuideOverlay(),
      const PlannerOverlay(),
      SettingsOverlay(rebuildCallback: () => reloadState())
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isEmergencyCentered =
        Provider.of<SettingsData>(context).isEmergencyCentered;

    fabLocation = _isEmergencyCentered
        ? FloatingActionButtonLocation.centerDocked
        : FloatingActionButtonLocation.endDocked;

    // The to be constructed appbar
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: topDownColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      actions: _active == 2 ? null : <Widget>[],
      title: Text(
        _active == 0
            ? 'Welcome to Nana Alert!'
            : _active == 1
                ? 'Planner'
                : '',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );

    return Scaffold(
        backgroundColor:
            // _active == 0 || _active == 1 ? Colors.blue[800] :
            Colors.deepPurple[50],
        appBar: _active == 2
            ? PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: appBar,
              )
            : appBar,
        body: _overlays[_active],
        floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            shape: const CircleBorder(),
            child: const Icon(Icons.warning_amber_sharp, color: Colors.black)),
        floatingActionButtonLocation: fabLocation,
        bottomNavigationBar: BottomAppBar(
          color: topDownColor,
          shape: const CircularNotchedRectangle(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: <Widget>[
            BottomAppBarIconButton(
              onTap: () => setActiveScreen(0),
              icon: Icon(_active == 0 ? Icons.book : Icons.book_outlined),
              padding: padding,
              textStyle: _active == 0
                  ? labelTextStyle.copyWith(fontWeight: FontWeight.bold)
                  : labelTextStyle,
              label: "Guide",
            ),
            BottomAppBarIconButton(
              onTap: () => setActiveScreen(1),
              icon: Icon(_active == 1
                  ? Icons.calendar_today
                  : Icons.calendar_today_outlined),
              padding: padding,
              textStyle: _active == 1
                  ? labelTextStyle.copyWith(fontWeight: FontWeight.bold)
                  : labelTextStyle,
              label: "Planner",
            ),
            if (_isEmergencyCentered) const Spacer(),
            BottomAppBarIconButton(
              onTap: () => setActiveScreen(2),
              icon:
                  Icon(_active == 2 ? Icons.settings : Icons.settings_outlined),
              padding: padding,
              textStyle: _active == 2
                  ? labelTextStyle.copyWith(fontWeight: FontWeight.bold)
                  : labelTextStyle,
              label: "Settings",
            ),
            if (!_isEmergencyCentered) const Spacer(),
          ]),
        ));
  }
}

class BottomAppBarIconButton extends StatelessWidget {
  const BottomAppBarIconButton(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.label,
      this.padding,
      this.color,
      this.iconSize,
      this.textStyle});

  final EdgeInsetsGeometry? padding;
  final void Function() onTap;
  final Widget icon;
  final Color? color;
  final double? iconSize;
  final TextStyle? textStyle;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          splashColor: Colors.deepPurple[200],
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon,
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: textStyle,
                )
              ],
            ),
          )),
    );
  }
}
