import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../domain/models/about_automotive_model.dart';
import '../../../widgets/frame/frame_scaffold.dart';
import 'about_automotive_list.dart';

class LihatSemuaView extends StatelessWidget {
  const LihatSemuaView({
    super.key,
    required this.aboutAutomotiveList,
  });

  final List<AboutAutomotiveModel> aboutAutomotiveList;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 60,
            isImplyLeading: true,
            onBack: () => router.pop(),
            titleScreen: 'News',
            elevation: 0,
            color: Platform.isIOS ? AppColors.black : AppColors.blackBackground,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.white,
            statusBarBrightness: Brightness.light,
            view: ListView.builder(
                itemCount: aboutAutomotiveList.length,
                itemBuilder: (BuildContext context, int index) =>
                    AboutAutomotiveList(
                      width: 90,
                      model: aboutAutomotiveList[index],
                    ))));
  }
}
