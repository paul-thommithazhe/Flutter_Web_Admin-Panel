import 'package:admin_panel_take_it/constants/controllers.dart';
import 'package:admin_panel_take_it/constants/style.dart';
import 'package:admin_panel_take_it/helpers/responsiveness.dart';
import 'package:admin_panel_take_it/routing/routes.dart';
import 'package:admin_panel_take_it/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key? key,
    required this.itemName,
    required this.onTap,
  }) : super(key: key);
  final String itemName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    const Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      // if (item.route == authenticationPageRoute) {
                      //   Get.offAllNamed(authenticationPageRoute);
                      //   menuController
                      //       .changeActiveItemTo(overviewPageDisplayName);
                      // }
                      // if (!menuController.isActive(item.name)) {
                      //   menuController.changeActiveItemTo(item.name);
                      //   if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                      //   navigationController.navigateTo(item.route);
                      // }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
