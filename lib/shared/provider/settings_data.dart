import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData with ChangeNotifier {
  bool _isEmergencyCentered = false;

  bool get isEmergencyCentered => _isEmergencyCentered;

  SettingsData() {
    _isEmergencyCentered = false;
    // Read the data on the creation of a state
    getIsEmergencyCentered();
  }

  void getIsEmergencyCentered() async {
    // Load the data from the shared preferences
    final prefs = await SharedPreferences.getInstance();
    _isEmergencyCentered = prefs.getBool("isEmergencyCentered") ?? false;
    notifyListeners();
  }

  void toggleEmergencyCentered() async {
    // Load the shared preferences
    final prefs = await SharedPreferences.getInstance();
    _isEmergencyCentered = !_isEmergencyCentered;
    await prefs.setBool("isEmergencyCentered", !_isEmergencyCentered);
  }
}
