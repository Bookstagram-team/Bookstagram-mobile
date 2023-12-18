import 'package:bookstagram/profile/screens/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? getUser() {
    return _user;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
