import 'package:amazone_clonee/model/usermodel.dart';
import 'package:flutter/material.dart';

class User_Provider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    name: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;
  void setUser(String user) {
    _user = User.fromjson(user);
    notifyListeners();
  }

  void setUserFromOdel(User user) {
    _user = user;
    notifyListeners();
  }
}
