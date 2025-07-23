import 'dart:convert';

import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../globals.dart/globls.dart';

class HomeServices {
  Future<List<Productmodel>> fetchCateogryProducts({
    required BuildContext context,
    required String cateogry,
  }) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);
    List<Productmodel> productlist = [];

    try {
      http.Response response = await http.get(
        Uri.parse("${Globls.Uri}/api/get-products?cateogry=$cateogry"),
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

  Future<Productmodel> fetchDealofDay({
    required BuildContext context,
  }) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);
    Productmodel product = Productmodel(
      name: '',
      description: '',
      quantity: 0.0,
      category: '',
      images: [],
      price: 0,
    );

    try {
      http.Response response = await http.get(
        Uri.parse("${Globls.Uri}/api/dealoftheday"),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'token': userprovider.user.token,
        },
      );
      httperrorhandler(
        context: context,
        response: response,
        onsucess: () {
          product = Productmodel.fromJson(response.body);
        },
      );
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return product;
  }
}
