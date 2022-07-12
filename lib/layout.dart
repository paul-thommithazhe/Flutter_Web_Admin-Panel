import 'package:admin_panel_take_it/helpers/responsiveness.dart';
import 'package:admin_panel_take_it/widgets/large_screen.dart';
import 'package:admin_panel_take_it/widgets/side_menu.dart';
import 'package:admin_panel_take_it/widgets/small_screen.dart';
import 'package:admin_panel_take_it/widgets/top_navbar.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: const ResponsiveWidget(
        largerScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
