import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../controllers/home_service_manager_controller.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../domain/models/specialist_model.dart';
import '../../../widgets/custom/custom_flat_button.dart';
import '../../../widgets/custom/custom_ripple_button.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../../../widgets/frame/frame_scaffold.dart';
import '../../../widgets/text/inter_text_view.dart';

class SelectSpecialist extends StatelessWidget {
  const SelectSpecialist({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 60,
            isUseLeading: true,
            titleScreen: 'Select Specialist',
            isCenter: true,
            elevation: 0,
            color: AppColors.blackBackground,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.white,
            statusBarBrightness: Brightness.light,
            view: GetBuilder<HomeServiceManagerController>(
              init: HomeServiceManagerController(),
              builder:
                  (HomeServiceManagerController homeServiceManagerController) =>
                      Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.COLUMN,
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                            child: CustomTextField(
                                width: 92,
                                borderRadius: 1,
                                hintText: 'ketik spesialist',
                                prefixIcon: const Icon(Icons.search),
                                onChanged: (String p0) =>
                                    homeServiceManagerController
                                        .searchSpecialist(p0),
                                title: '')),
                        ResponsiveRowColumnItem(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.horizontal(10)),
                              itemCount: homeServiceManagerController
                                      .foundedSpecialist.isNotEmpty
                                  ? homeServiceManagerController
                                      .foundedSpecialist.length
                                  : homeServiceManagerController
                                      .specialistList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final SpecialistModel item =
                                    homeServiceManagerController
                                        .specialistList[index];
                                return CustomRippleButton(
                                  borderRadius: BorderRadius.zero,
                                  onTap: () => homeServiceManagerController
                                      .toggleSelectionSpecialist(item),
                                  child: listTileModel(
                                      homeServiceManagerController
                                              .foundedSpecialist.isNotEmpty
                                          ? homeServiceManagerController
                                              .foundedSpecialist[index]
                                          : homeServiceManagerController
                                              .specialistList[index],
                                      homeServiceManagerController),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: SizeConfig.horizontal(2)),
                      height: SizeConfig.horizontal(10),
                      width: SizeConfig.horizontal(40),
                      child: CustomFlatButton(
                          width: 80,
                          height: 8,
                          text:
                              'Selected (${homeServiceManagerController.specialistSelected.length})',
                          onTap: () {
                            Get.back();
                          }),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget listTileModel(SpecialistModel model,
      HomeServiceManagerController homeServiceManagerController) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.horizontal(0.5)),
      child: ListTile(
        tileColor: model.isSelected == true ? AppColors.blackBackground : null,
        title: InterTextView(
          value: model.brand,
          color: AppColors.black,
        ),
      ),
    );
  }
}
