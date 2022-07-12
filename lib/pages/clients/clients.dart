import 'package:admin_panel_take_it/widgets/custom_text.dart';

import 'package:flutter/widgets.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        text: 'Clients',
      ),
    );
  }
}
