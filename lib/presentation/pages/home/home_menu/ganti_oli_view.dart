import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../controllers/home/ganti_oli_controller.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../widgets/custom/custom_calendar_picker.dart';
import '../../../widgets/custom/custom_flat_button.dart';
import '../../../widgets/custom/custom_ripple_button.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../../../widgets/frame/frame_scaffold.dart';
import '../../../widgets/layouts/space_sizer.dart';
import '../../../widgets/text/inter_text_view.dart';
import '../../akun/akun_view.dart';

class GantiOliView extends StatelessWidget {
  const GantiOliView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 60,
            isUseLeading: true,
            titleScreen: 'Service Ganti Oli',
            isCenter: true,
            elevation: 0,
            color: AppColors.blackBackground,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.greyBackground,
            statusBarBrightness: Brightness.light,
            view: GetBuilder<GantiOliController>(
                init: GantiOliController(),
                builder: (GantiOliController gantiOliController) =>
                    ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        children: <ResponsiveRowColumnItem>[
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                          ResponsiveRowColumnItem(
                              child: WhiteBackgroundContainer(
                                  alignment: Alignment.center,
                                  child: CustomTextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      height: 10,
                                      width: 90,
                                      titleFontWeight: FontWeight.bold,
                                      borderRadius: 0,
                                      textColor: AppColors.black,
                                      title: 'Titipkan Pesan',
                                      suffixIcon: Icon(Icons.note_alt_outlined,
                                          size: SizeConfig.horizontal(8),
                                          color: AppColors.blueColor),
                                      hintText:
                                          'Apa Pesan mu?\nex:Saya hanya memiliki oli saja tolong\nbawakan peralatannya'))),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                          ResponsiveRowColumnItem(
                              child: SearchBox(
                            gantiOliController: gantiOliController,
                          )),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                          ResponsiveRowColumnItem(
                              child: WhiteBackgroundContainer(
                            child: ResponsiveRowColumn(
                              layout: ResponsiveRowColumnType.COLUMN,
                              columnPadding: EdgeInsets.only(
                                  left: SizeConfig.horizontal(5),
                                  right: SizeConfig.horizontal(4)),
                              columnCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: <ResponsiveRowColumnItem>[
                                ResponsiveRowColumnItem(
                                    child: InterTextView(
                                  value: '*Jadwalin Dulu Gak sih',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                                ResponsiveRowColumnItem(
                                  child: Obx(
                                    () => CalendarPreviewButton(
                                      gantiOliController: gantiOliController,
                                      startDate: gantiOliController
                                          .rangeStartGeneralCalendar.value,
                                      endDate: gantiOliController
                                          .rangeEndGeneralCalendar.value,
                                      onTap: gantiOliController.onOpenCalendar,
                                    ),
                                  ),
                                ),
                                const ResponsiveRowColumnItem(
                                    child: SpaceSizer(vertical: 2)),
                                ResponsiveRowColumnItem(
                                    child: Center(
                                  child: CustomFlatButton(
                                    width: 75,
                                    text: 'Pesan Sekarang',
                                    onTap: () {},
                                  ),
                                ))
                              ],
                            ),
                          ))
                        ]))));
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.gantiOliController,
  });
  final GantiOliController gantiOliController;
  @override
  Widget build(BuildContext context) {
    return WhiteBackgroundContainer(
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnPadding: EdgeInsets.only(left: SizeConfig.horizontal(5)),
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: InterTextView(
                  value: 'Ayo Temukan Jagoan Beresmu',
                  color: AppColors.black,
                  fontWeight: FontWeight.bold)),
          ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.COLUMN,
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            children: <ResponsiveRowColumnItem>[
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ResponsiveRowColumnItem(
                  child: InterTextView(
                      value: 'Jenis Kendaraan',
                      color: AppColors.black,
                      size: SizeConfig.safeBlockHorizontal * 4,
                      fontWeight: FontWeight.w500)),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ResponsiveRowColumnItem(
                  child: CustomRippleButton(
                      borderRadius: BorderRadius.zero,
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.horizontal(4)))),
                          context: context,
                          builder: (BuildContext context) =>
                              DraggableScrollableSheet(
                            expand: false,
                            builder: (BuildContext context,
                                    ScrollController scrollController) =>
                                SizedBox(
                              height: SizeConfig.horizontal(20),
                              child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.COLUMN,
                                columnMainAxisSize: MainAxisSize.min,
                                columnCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                      child: Padding(
                                          padding: EdgeInsets.all(
                                              SizeConfig.horizontal(4)),
                                          child: InterTextView(
                                              value: 'Jenis Kendaraan',
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4.5))),
                                  ResponsiveRowColumnItem(
                                      child: Expanded(
                                    child: ListView.builder(
                                      itemCount: gantiOliController
                                          .pilihKendaraanText.length,
                                      itemBuilder: (_, int index) =>
                                          CustomDividerText(
                                        useArrowIcon: false,
                                        isCenter: false,
                                        title: gantiOliController
                                            .pilihKendaraanText[index],
                                        textSize: 5,
                                        iconSize: 50,
                                        onTap: () => gantiOliController
                                            .onChangeKendaraan(
                                                gantiOliController
                                                    .pilihKendaraanText[index]),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                          width: SizeConfig.horizontal(90),
                          height: SizeConfig.horizontal(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.horizontal(1))),
                              color: AppColors.white,
                              border: Border.all(
                                  width: SizeConfig.horizontal(0.2))),
                          child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.ROW,
                            rowPadding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.horizontal(2)),
                            children: <ResponsiveRowColumnItem>[
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(horizontal: 1)),
                              ResponsiveRowColumnItem(
                                  child: Obx(() => InterTextView(
                                      value: gantiOliController.onChangeText(),
                                      color: gantiOliController
                                          .onChangeTextColor(),
                                      size:
                                          SizeConfig.safeBlockHorizontal * 3.5,
                                      fontWeight: FontWeight.w500))),
                              const ResponsiveRowColumnItem(child: Spacer()),
                              ResponsiveRowColumnItem(
                                  child: Icon(Icons.arrow_drop_down_circle,
                                      color: AppColors.blueDark, size: 25)),
                            ],
                          )))),
              ResponsiveRowColumnItem(
                  child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.ROW,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                    child: Obx(
                      () => Checkbox(
                          side: BorderSide(
                              width: SizeConfig.horizontal(0.7),
                              color: AppColors.blueDark),
                          value: gantiOliController.isCheckedJagoan.value,
                          onChanged: (bool? v0) {
                            gantiOliController.isCheckedJagoan.value = v0!;
                          }),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: InterTextView(
                      value: 'Gunakan Jagoan Saktiku',
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      size: SizeConfig.safeBlockHorizontal * 3.5,
                    ),
                  ),
                ],
              )),
              ResponsiveRowColumnItem(
                  child: Obx(
                () => gantiOliController.isCheckedJagoan.isFalse
                    ? Center(
                        child: InterTextView(
                          value:
                              'Jarak KM Pencarian : ${gantiOliController.sliderVal.value.toInt()}*',
                          fontWeight: FontWeight.w600,
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          color: AppColors.black,
                        ),
                      )
                    : const SizedBox.shrink(),
              )),
              ResponsiveRowColumnItem(
                  child: Obx(() => gantiOliController.isCheckedJagoan.isFalse
                      ? SizedBox(
                          width: SizeConfig.horizontal(90),
                          child: Slider(
                              max: 50,
                              label:
                                  '${gantiOliController.sliderVal.value.round()}',
                              divisions: 5,
                              activeColor: AppColors.blueDark,
                              thumbColor: AppColors.blueDark,
                              value: gantiOliController.sliderVal.value,
                              onChanged: (double value) =>
                                  gantiOliController.onChangeSlider(value)),
                        )
                      : const SizedBox.shrink())),
              ResponsiveRowColumnItem(
                  child: Obx(
                () => gantiOliController.sliderVal.value == 0 &&
                        gantiOliController.isCheckedJagoan.isFalse
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.horizontal(9)),
                        child: CustomFlatButton(
                            width: 70,
                            height: 5,
                            text: 'Gas!!! Cari',
                            backgroundColor: AppColors.greyDisabled,
                            onTap: () {
//  Snack.show(SnackbarType.info, 'Radius 0',
//                               'Radius Gak boleh kosong yah :)'),
                            }),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.horizontal(
                                gantiOliController.isCheckedJagoan.isFalse
                                    ? 9
                                    : 20)),
                        child: CustomFlatButton(
                          width: gantiOliController.isCheckedJagoan.isFalse
                              ? 70
                              : 50,
                          height: 5,
                          text: gantiOliController.isCheckedJagoan.isFalse
                              ? 'Gas!!! Cari'
                              : 'Gas!!! Pilih JagoanMu',
                          onTap: () {},
                        ),
                      ),
              ))
            ],
          ))
        ],
      ),
    );
  }
}

class WhiteBackgroundContainer extends StatelessWidget {
  const WhiteBackgroundContainer({
    super.key,
    this.child,
    this.alignment,
  });

  final Widget? child;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.horizontal(3)),
        alignment: alignment ?? Alignment.centerLeft,
        width: SizeConfig.screenWidth,
        color: AppColors.white,
        child: child);
  }
}
