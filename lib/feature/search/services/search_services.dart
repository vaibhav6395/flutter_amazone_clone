import 'dart:convert';

import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../globals.dart/globls.dart';

class SearchServices {
  Future<List<Productmodel>> fetchedSearchProducts({
    required BuildContext context,
    required String searchquery,
  }) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);
    List<Productmodel> productlist = [];

    try {
      http.Response response = await http.get(
        Uri.parse(
          "${Globls.Uri}/api/get-products/search/$searchquery",
        ), // passing search query as an param
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
            productlist.add(
              Productmodel.fromJson(jsonEncode(jsonDecode(response.body)[i])),

              //   json decode is used to convert api json String into Dart map
              // and  jsonencode is used to covert Dart map into json String so that it can be passable in this method
              // insetad use directly  Productmodel.fromMap(jsonDecode(response.body)[i])
            );
          }
        },
      );
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return productlist;
  }
}
