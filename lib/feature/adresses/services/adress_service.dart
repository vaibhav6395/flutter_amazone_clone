import 'dart:convert';
import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:amazone_clonee/model/usermodel.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../globals.dart/globls.dart' show Globls;

class AdressService {
  // upload product for selling
  void saveUseAdress({
    required BuildContext context,
    required String Address,
  }) async {
    final usrprovider = Provider.of<User_Provider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse("${Globls.Uri}/api/saveUserAddress"),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'token': usrprovider.user.token,
        },
        body: jsonEncode({'address': Address}),
      );
      httperrorhandler(
        context: context,
        response: response,
        onsucess: () {
          User user = usrprovider.user.copyWith(
            address: jsonDecode(response.body)['adress'],
          );
          usrprovider.setUserFromOdel(user);
        },
      );
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  // get all the  Products(),
  // /admin/get-products
  void placeOrder({
    required BuildContext context,
    required String Address,
    required double totalsum,
  }) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse("${Globls.Uri}/api/order"),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'token': userprovider.user.token,
        },
        body: jsonEncode({
          'cart': userprovider.user.cart,
          'address': Address,
          'totalprice': totalsum,
        }),
      );
      httperrorhandler(
        context: context,
        response: response,
        onsucess: () {
          Showsnackbar(context, 'Your order has Been placed');
          User user = userprovider.user.copyWith(cart: []);
          userprovider.setUserFromOdel(user);
        },
      );
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  void deleteproduct({
    required BuildContext context,
    required Productmodel product,
    required VoidCallback onsucess,
  }) async {
    final usrprovider = Provider.of<User_Provider>(context, listen: false);
    if (product.id == null) {
      Showsnackbar(context, "Product ID is null. Cannot delete product.");
    }
    try {
      http.Response response = await http.post(
        Uri.parse("${Globls.Uri}/admin/delete-products"),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'token': usrprovider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }), // converted dart map into json to send  value of id
      );
      httperrorhandler(
        context: context,
        response: response,
        onsucess: () {
          onsucess();
        },
      );
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }
}
