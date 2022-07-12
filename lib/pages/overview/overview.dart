import 'package:admin_panel_take_it/widgets/custom_text.dart';
import 'package:flutter/widgets.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        text: 'overview',
      ),
    );
  }
}
