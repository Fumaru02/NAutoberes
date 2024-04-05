import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../domain/models/specialist_model.dart';
import '../../../blocs/home_service_manager/home_service_manager_bloc.dart';
import '../../../cubits/home_service_manager/home_service_manager_cubit.dart';
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
            view: BlocBuilder<HomeServiceManagerCubit,
                HomeServiceManagerStateCubit>(
              builder: (_, HomeServiceManagerStateCubit state) {
                return Stack(
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
                                  onChanged: (String p0) => context
                                      .read<HomeServiceManagerCubit>()
                                      .searchSpecialist(p0),
                                  title: '')),
                          ResponsiveRowColumnItem(
                            child: BlocBuilder<HomeServiceManagerBloc,
                                HomeServiceManagerState>(
                              builder: (_, HomeServiceManagerState homeState) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        bottom: SizeConfig.horizontal(10)),
                                    itemCount:
                                        state.foundedSpecialist.isNotEmpty
                                            ? state.foundedSpecialist.length
                                            : homeState.specialistList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final SpecialistModel item =
                                          homeState.specialistList[index];
                                      return CustomRippleButton(
                                        borderRadius: BorderRadius.zero,
                                        onTap: () => context
                                            .read<HomeServiceManagerCubit>()
                                            .toggleSelectionSpecialist(item),
                                        child: listTileModel(
                                          state.foundedSpecialist.isNotEmpty
                                              ? state.foundedSpecialist[index]
                                              : homeState.specialistList[index],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: SizeConfig.horizontal(2)),
                        height: SizeConfig.horizontal(10),
                        width: SizeConfig.horizontal(40),
                        child: CustomFlatButton(
                            width: 80,
                            height: 8,
                            text:
                                'Selected (${state.selectedSpecialist.length})',
                            onTap: () {
                              Get.back();
                            }),
                      ),
                    )
                  ],
                );
              },
            )));
  }

  Widget listTileModel(
    SpecialistModel model,
  ) {
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
