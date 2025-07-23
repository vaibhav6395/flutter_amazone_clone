import 'dart:convert';
import 'dart:io';

import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../globals.dart/globls.dart' show Globls;

class AdminServices {

                     // upload product for selling 
  void sellproducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String cateogry,
    required List<File> Images,
  }) async {
    final usrprovider = Provider.of<User_Provider>(context, listen: false);
    try {
      final Cloudinary = CloudinaryPublic('dhruolksa', 'amazone_preset');
      List<String> imageurls = [];
      for (int i = 0; i < Images.length; i++) {
        CloudinaryResponse clodresponse = await Cloudinary.uploadFile(
          CloudinaryFile.fromFile(Images[i].path, folder: name),
        );
        imageurls.add(clodresponse.secureUrl);

        Productmodel newproductmodel = Productmodel(
          name: name,
          description: description,
          quantity: quantity,
          category: cateogry,
          images: imageurls,
          price: price,
        );
        http.Response response = await http.post(
          Uri.parse("${Globls.Uri}/admin/addproduct"),
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'token': usrprovider.user.token,
          },
          body: newproductmodel.toJson(),
        );
        httperrorhandler(
          context: context,
          response: response,
          onsucess: () {
            Showsnackbar(context, 'Product added Sucessfully');
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  // get all the  Products(),
  // /admin/get-products
  Future<List<Productmodel>> fetchallproduct(BuildContext context) async {
    final userprovider = Provider.of<User_Provider>(context, listen: false);
    List<Productmodel> productlist = [];

    try {
      http.Response response = await http.get(
        Uri.parse("${Globls.Uri}/admin/get-products"),
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
        body: jsonEncode({'id': product.id}),   // converted dart map into json to send  value of id 
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
