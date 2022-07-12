import 'package:admin_panel_take_it/constants/controllers.dart';
import 'package:admin_panel_take_it/routing/router.dart';
import 'package:admin_panel_take_it/routing/routes.dart';
import 'package:flutter/cupertino.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: overViewPageRoute,
      onGenerateRoute: generateRoute,
    );
