import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/akun_controller.dart';
import '../widgets/custom/custom_flat_button.dart';

class AkunView extends StatelessWidget {
  const AkunView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AkunController>(
      init: AkunController(),
      builder: (AkunController akunController) => CustomFlatButton(
        onTap: () => akunController.signOut(),
        text: 'Log out',
      ),
    );
  }
}
