import 'dart:convert';

import 'package:amazone_clonee/common/widgets/bottombar.dart';
import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:amazone_clonee/model/usermodel.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:amazone_clonee/feature/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller {
  String token = '';
  Future<void> signupuser({
    required String name,
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: name,
        password: password,
        address: '',
        type: '',
        token: '',
         cart: [],
      );
      http.Response res = await http.post(
        Uri.parse("${Globls.Uri}/api/signup"),
        body: jsonEncode(user.fromApptoDB()),
        headers: <String, String>{
          'Content-type': 'application/json;charset=UTF-8',
        },
      );
      httperrorhandler(
        context: context,
        response: res,
        onsucess: () {
          Showsnackbar(
            context,
            " Account created sucessflly !Please Sign-in with same Credentials.",
          );
          Navigator.pushNamed(context, Signin.routename);
        },
      );
    } catch (e) {
      Showsnackbar(context, "Error occured - ${e.toString()}");
    }
  }

  Future<void> Signinuser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("${Globls.Uri}/api/signin"),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-type': 'application/json;charset=UTF-8',
        },
      );
      httperrorhandler(
        context: context,
        response: res,
        onsucess: () async {
          Showsnackbar(context, "Welcome Back!");
          SharedPreferences preferences = await SharedPreferences.getInstance();
          Provider.of<User_Provider>(context, listen: false).setUser(res.body);
          print("stamp value is this ${jsonDecode(res.body)['token']}");
          await preferences.setString("token", jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Bottombar.routename,
            (route) => false,
          );
        },
      );
    } catch (e) {
      Showsnackbar(context, "Error occured - ${e.toString()}");
    }
  }

  Future<void> fetchuserdata(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? stamp = sharedPreferences.getString("token");
    if (stamp == null) {
      sharedPreferences.setString("token", "");
      print("token value$stamp");
    }
    var tokenres = await http.post(
      Uri.parse("${Globls.Uri}/validatetoken"),
      headers: <String, String>{
        'Content-type': 'application/json;charset=UTF-8',
        'token': stamp!,
      },
    );
    token = stamp;
    var response = jsonDecode(tokenres.body);
    print(tokenres.body);
    if (response == true) {
      http.Response userresp = await http.get(
        Uri.parse("${Globls.Uri}/"),
        headers: <String, String>{
          'Content-type': 'application/json;charset=UTF-8',
          'token': stamp,
        },
      );
      print(userresp.body);

      var userprovider = Provider.of<User_Provider>(context, listen: false);
      userprovider.setUser(userresp.body);
    } else {
      print("token is not verified");
    }
  }
}
