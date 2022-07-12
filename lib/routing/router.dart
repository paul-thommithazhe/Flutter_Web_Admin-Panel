import 'package:admin_panel_take_it/pages/clients/clients.dart';
import 'package:admin_panel_take_it/pages/driver/driver.dart';
import 'package:admin_panel_take_it/pages/overview/overview.dart';
import 'package:admin_panel_take_it/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overViewPageRoute:
      return _getPageRoute(const OverViewPage());
    case driversPageRoute:
      return _getPageRoute(const DriversPage());
    case clientsPageRoute:
      return _getPageRoute(const ClientsPage());
    default:
      return _getPageRoute(const OverViewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
