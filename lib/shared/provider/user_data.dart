import 'package:flutter/material.dart';
import 'package:nana_alert/models/user.dart';

class UserData with ChangeNotifier {
  // TODO: Implement
  User? _user;
  Map<String, dynamic>? userData = {};

  User? get user => _user;

  void setUser(User user, Map<String, dynamic>? info) {
    _user = user;
    userData = info;
  }

  void clearUser() {
    _user = null;
    userData = {};
  }
}
