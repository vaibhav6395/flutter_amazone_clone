import 'package:amazone_clonee/common/widgets/bottombar.dart';
import 'package:amazone_clonee/feature/admin/screen/addproductscreen.dart';
import 'package:amazone_clonee/feature/adresses/screen/adressscreen.dart';
import 'package:amazone_clonee/feature/auth/signin.dart';
import 'package:amazone_clonee/feature/auth/singup.dart';
import 'package:amazone_clonee/feature/home/screen/cateogrydealscreen.dart';
import 'package:amazone_clonee/feature/home/screen/homescreen.dart';
import 'package:amazone_clonee/feature/order_details/screen/orderdetailscreen.dart';
import 'package:amazone_clonee/feature/product_detail/screen/productdetailscreen.dart';
import 'package:amazone_clonee/feature/search/screen/searchscreen.dart';
import 'package:amazone_clonee/model/order.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:flutter/material.dart';

MaterialPageRoute genereateRouter(RouteSettings routesettings) {
  switch (routesettings.name) {
    case Singup.routename:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Singup(),
      );
       case Orderdetailscreen.routename:
             var order = routesettings.arguments as Order;

      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Orderdetailscreen(order: order,),
      );
    case Adressscreen.routename:
      var totalamount = routesettings.arguments as String;
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Adressscreen(amount: totalamount),
      );
    case Productdetailscreen.routename:
      var product = routesettings.arguments as Productmodel;
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Productdetailscreen(Product: product),
      );
    case Searchscreen.routename:
      var searchquery = routesettings.arguments as String;
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Searchscreen(Searchquery: searchquery),
      );

    case Cateogrydealscreen.routename:
      var cateogry = routesettings.arguments as String;
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Cateogrydealscreen(Cateogry: cateogry),
      );
    case Addproductscreen.routename:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Addproductscreen(),
      );
    case Homescreen.routename:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Homescreen(),
      );
    case Signin.routename:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Signin(),
      );
    case Bottombar.routename:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Bottombar(),
      );
    default:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => Scaffold(),
      );
  }
}
