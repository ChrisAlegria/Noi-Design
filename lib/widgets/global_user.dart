import 'package:flutter/material.dart';

class GlobalUser extends ChangeNotifier {
  String _email = '';

  String get email => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
}
