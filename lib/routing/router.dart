import 'package:admin_panel_take_it/pages/category/category.dart';
import 'package:admin_panel_take_it/pages/coupon/coupons.dart';
import 'package:admin_panel_take_it/pages/home/home_screen.dart';
import 'package:admin_panel_take_it/pages/offer/offer.dart';
import 'package:admin_panel_take_it/pages/order/order.dart';
import 'package:admin_panel_take_it/pages/products/products.dart';
import 'package:admin_panel_take_it/pages/sales/sales.dart';
import 'package:admin_panel_take_it/pages/user/user.dart';
import 'package:admin_panel_take_it/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return _getPageRoute(HomePage());
    case usersPageRoute:
      return _getPageRoute(const UsersPage());
    case productsPageRoute:
      return _getPageRoute(ProductsPage());
    case couponPageRoute:
      return _getPageRoute(const CouponPage());
    case categoryPageRoute:
      return _getPageRoute(const CategoryPage());
    case order:
      return _getPageRoute(const OrderPage());
    case salesPageReport:
      return _getPageRoute(const SalesPage());
    default:
      return _getPageRoute(HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
