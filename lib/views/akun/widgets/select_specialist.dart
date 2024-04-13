import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/register_home_service_controller.dart';
import '../../../models/specialist/specialist_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../../widgets/custom/custom_flat_button.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/custom/custom_text_field.dart';
import '../../widgets/frame/frame_scaffold.dart';
import '../../widgets/text/inter_text_view.dart';

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
            view: GetBuilder<RegisterHomeServiceManagerController>(
              init: RegisterHomeServiceManagerController(),
              builder: (RegisterHomeServiceManagerController
                      registerHomeServiceManagerController) =>
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
                                    registerHomeServiceManagerController
                                        .searchSpecialist(p0),
                                title: '')),
                        ResponsiveRowColumnItem(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.horizontal(10)),
                              itemCount: registerHomeServiceManagerController
                                      .foundedSpecialist.isNotEmpty
                                  ? registerHomeServiceManagerController
                                      .foundedSpecialist.length
                                  : registerHomeServiceManagerController
                                      .specialistList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final SpecialistModel item =
                                    registerHomeServiceManagerController
                                        .specialistList[index];
                                return CustomRippleButton(
                                  borderRadius: BorderRadius.zero,
                                  onTap: () =>
                                      registerHomeServiceManagerController
                                          .toggleSelectionSpecialist(item),
                                  child: listTileModel(
                                      registerHomeServiceManagerController
                                              .foundedSpecialist.isNotEmpty
                                          ? registerHomeServiceManagerController
                                              .foundedSpecialist[index]
                                          : registerHomeServiceManagerController
                                              .specialistList[index],
                                      registerHomeServiceManagerController),
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
                              'Selected (${registerHomeServiceManagerController.specialistSelected.length})',
                          onTap: () {
                            Get.back();
                          }),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget listTileModel(
      SpecialistModel model,
      RegisterHomeServiceManagerController
          registerHomeServiceManagerController) {
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
