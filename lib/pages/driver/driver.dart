import 'package:admin_panel_take_it/widgets/custom_text.dart';

import 'package:flutter/widgets.dart';

class DriversPage extends StatelessWidget {
  const DriversPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        text: 'Drivers',
      ),
    );
  }
}
