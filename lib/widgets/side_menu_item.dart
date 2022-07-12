import 'package:admin_panel_take_it/helpers/responsiveness.dart';
import 'package:admin_panel_take_it/widgets/horizontal_menu_item.dart';
import 'package:admin_panel_take_it/widgets/vertical_menu_item.dart';
import 'package:flutter/material.dart';


class SideMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;

  const SideMenuItem({
    Key? key,
    required this.itemName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomize(context)) {
      return VertticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
  }
}
