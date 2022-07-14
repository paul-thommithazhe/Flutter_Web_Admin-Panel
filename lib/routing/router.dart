
import 'package:admin_panel_take_it/pages/coupon/coupons.dart';
import 'package:admin_panel_take_it/pages/home/home_screen.dart';
import 'package:admin_panel_take_it/pages/offer/offer.dart';
import 'package:admin_panel_take_it/pages/products/products.dart';
import 'package:admin_panel_take_it/pages/sales/sales.dart';
import 'package:admin_panel_take_it/pages/user/user.dart';
import 'package:admin_panel_take_it/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return _getPageRoute(const HomePage());
    case usersPageRoute:
      return _getPageRoute(const UsersPage());
    case productsPageRoute:
      return _getPageRoute( ProductsPage());
    case offerPageRoute:
      return _getPageRoute(const OfferPage());
    case couponPageRoute:
      return _getPageRoute(const CouponPage());
    case salesPageReport:
      return _getPageRoute(const SalesPage());
    default:
      return _getPageRoute(const HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
