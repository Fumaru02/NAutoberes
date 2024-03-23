import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controllers/authorize_controller.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../widgets/custom/custom_html_wrapper.dart';
import '../../../widgets/frame/frame_scaffold.dart';

class KetentuanDanKebijakanPrivasi extends StatelessWidget {
  const KetentuanDanKebijakanPrivasi({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorizeController authorizeController =
        Get.put(AuthorizeController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 60,
            isUseLeading: true,
            titleScreen: 'Ketentuan dan Kebijakan Privasi',
            elevation: 0,
            color: AppColors.blackBackground,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.greyBackground,
            statusBarBrightness: Brightness.light,
            view: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                CustomHtmlWrapper(
                  data: authorizeController.termsOfUse.value,
                ),
                CustomHtmlWrapper(
                  data: authorizeController.privacyPolicy.value,
                ),
              ],
            ))));
  }
}
