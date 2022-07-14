import 'package:admin_panel_take_it/constants/style.dart';
import 'package:admin_panel_take_it/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = homePageRoute.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case homePageRoute:
        return _customIcon(Icons.trending_up, itemName);
      case usersPageRoute:
        return _customIcon(Icons.people, itemName);
      case productsPageRoute:
        return _customIcon(Icons.shopping_bag, itemName);
      case offerPageRoute:
        return _customIcon(Icons.money_off_csred_outlined, itemName);
      case couponPageRoute:
        return _customIcon(Icons.shopping_bag_outlined, itemName);
      case salesPageReport:
        return _customIcon(Icons.file_copy, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      Icon(
        icon,
        size: 22,
        color: dark,
      );
    }
    return Icon(icon, color: isHovering(itemName) ? dark : lightGrey);
  }
}
