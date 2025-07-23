import 'dart:convert';

import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/model/order.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../globals.dart/globls.dart';

class AccountServices {
  Future<List<Order>> fetchmyOrders({
    required BuildContext context,
  }) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);
    List<Order> orderlist = [];

    try {
      http.Response response = await http.get(
        Uri.parse("${Globls.Uri}/api/order/me"),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'token': userprovider.user.token,
        },
      );
      httperrorhandler(
        context: context,
        response: response,
        onsucess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            orderlist.add(
              Order.fromJson(jsonEncode(jsonDecode(response.body)[i])),

              //   json decode is used to convert api json String into Dart map
              // and  jsonencode is used to covert Dart map into json String so that it can be passable in this method
              // insetad use directly  Productmodel.fromMap(jsonDecode(response.body)[i])
            );
          }
        },
          );
          print(response.body[0].toString());
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return orderlist;
  }
}
