import 'dart:convert';

import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:amazone_clonee/model/usermodel.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../globals.dart/globls.dart';

class ProductdetailService {
  void rateproduct({
    required BuildContext context,
    required Productmodel Product,
    required double rating,
  }) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("${Globls.Uri}/api/rate-product"),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'token': userprovider.user.token,
        },
        body: jsonEncode({'id': Product.id, 'rating': rating}),
      );
      print(response.body);
      httperrorhandler(context: context, response: response, onsucess: () {});
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Productmodel Product,
  }) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("${Globls.Uri}/api/addToCart"),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'token': userprovider.user.token,
        },
        body: jsonEncode({'id': Product.id}),
      );
      print(response.body);
      print(response.body);
      httperrorhandler(
        context: context,
        response: response,
        onsucess: () {
          User usr = userprovider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userprovider.setUserFromOdel(usr);
        },
      );
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }
}
