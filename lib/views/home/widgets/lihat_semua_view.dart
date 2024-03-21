import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/frame/frame_scaffold.dart';
import 'about_automotive_list.dart';

class LihatSemuaView extends StatelessWidget {
  const LihatSemuaView({
    super.key,
    required this.homeController,
  });
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 60,
            isUseLeading: true,
            titleScreen: 'News',
            elevation: 0,
            color: Platform.isIOS ? AppColors.black : AppColors.blackBackground,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.white,
            statusBarBrightness: Brightness.light,
            view: ListView.builder(
                itemCount: homeController.aboutAutomotiveList.length,
                itemBuilder: (BuildContext context, int index) =>
                    AboutAutomotiveList(
                      width: 90,
                      model: homeController.aboutAutomotiveList[index],
                    ))));
  }
}
