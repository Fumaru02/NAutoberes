import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/home_service_manager_controller.dart';
import '../../../controllers/maps_controller.dart';
import '../../../core/constant/enums.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/asset_list.dart';
import '../../../core/utils/size_config.dart';
import '../../../domain/models/brands_car_model.dart';
import '../../widgets/custom/custom_confirmation_dialog.dart';
import '../../widgets/custom/custom_flat_button.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/custom/custom_text_field.dart';
import '../../widgets/frame/frame_scaffold.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/logo/autoberes_logo.dart';
import '../../widgets/text/inter_text_view.dart';
import '../home/home_menu/ganti_oli_view.dart';
import 'akun_view.dart';

class HomeServiceManagerView extends StatelessWidget {
  const HomeServiceManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    final MapsController mapsController = MapsController();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: KeyboardSizeProvider(
          child: FrameScaffold(
              heightBar: 60,
              isUseLeading: true,
              titleScreen: 'Home Service Manager',
              isCenter: true,
              elevation: 0,
              color: AppColors.blackBackground,
              statusBarColor: AppColors.blackBackground,
              colorScaffold: AppColors.greyBackground,
              statusBarBrightness: Brightness.light,
              view: GetBuilder<HomeServiceManagerController>(
                init: HomeServiceManagerController(),
                builder: (HomeServiceManagerController
                        homeServiceManagerController) =>
                    SingleChildScrollView(
                  child: Consumer<ScreenHeight>(
                    builder: (BuildContext context, ScreenHeight res,
                            Widget? child) =>
                        ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.COLUMN,
                      children: <ResponsiveRowColumnItem>[
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 1.5)),
                        ResponsiveRowColumnItem(
                            child: WhiteBackgroundContainer(
                          alignment: Alignment.center,
                          child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: res.isOpen
                                      ? const SizedBox.shrink()
                                      : HomeServicePictureWidget(
                                          homeServiceManagerController:
                                              homeServiceManagerController,
                                        )),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 2)),
                              ResponsiveRowColumnItem(
                                  child: CustomTextField(
                                borderRadius: 2,
                                title: 'Nama Usaha Individu Service',
                                hintText: 'contoh:Rian Motor',
                                controller: homeServiceManagerController.hsName,
                              )),
                              ResponsiveRowColumnItem(
                                  child: res.isOpen
                                      ? const SizedBox.shrink()
                                      : _mapImageWrapper(mapsController)),
                              ResponsiveRowColumnItem(
                                  child: addressBoxWrapper(mapsController,
                                      homeServiceManagerController)),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child: Obx(
                                () => mapsController.lat.isEmpty
                                    ? const SizedBox.shrink()
                                    : _dropdown(
                                        context, homeServiceManagerController),
                              )),
                              ResponsiveRowColumnItem(
                                  child: homeServiceManagerController
                                              .selectedDropDownMenu.value ==
                                          ''
                                      ? const SizedBox.shrink()
                                      : _brandsBox(
                                          homeServiceManagerController)),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child: homeServiceManagerController
                                              .selectedDropDownMenu.value ==
                                          ''
                                      ? const SizedBox.shrink()
                                      : _specialistsBox(
                                          homeServiceManagerController)),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child: CustomTextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      expands: true,
                                      height: SizeConfig.horizontal(30),
                                      title: 'Deskripsikan Kemampuan mu',
                                      hintText:
                                          'contoh: Saya adalah Seorang mekanik handal di daerah bekasi',
                                      borderRadius: 2,
                                      controller: homeServiceManagerController
                                          .hsSkill)),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 5)),
                              ResponsiveRowColumnItem(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    right: SizeConfig.horizontal(8)),
                                child: InterTextView(
                                  value:
                                      '*Pastikan kamu sudah mengisi alamat lengkap',
                                  size: SizeConfig.safeBlockHorizontal * 3,
                                  color: AppColors.redAlert,
                                ),
                              )),
                              ResponsiveRowColumnItem(
                                  child: Obx(
                                () => CustomFlatButton(
                                    loading: homeServiceManagerController
                                        .isLoading.value,
                                    text: 'Confirm',
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomConfirmationDialog(
                                                title: 'kamu yakin?',
                                                confirmText: 'Selesai',
                                                cancelText: 'Kembali',
                                                onConfirm: () =>
                                                    homeServiceManagerController
                                                        .onConfirm(
                                                  mapsController.lat.value,
                                                  mapsController.long.value,
                                                ),
                                              ));
                                    }),
                              ))
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              )),
        ));
  }

  ResponsiveRowColumn _specialistsBox(
      HomeServiceManagerController homeServiceManagerController) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: homeServiceManagerController.selectedSpecialistWrapper(),
                color: AppColors.black,
                size: SizeConfig.safeBlockHorizontal * 4,
                fontWeight: FontWeight.w500)),
        ResponsiveRowColumnItem(
            child: CustomRippleButton(
                borderRadius: BorderRadius.zero,
                onTap: () => homeServiceManagerController.verifySpecialist(),
                child: Container(
                  width: SizeConfig.horizontal(80),
                  height:
                      homeServiceManagerController.specialistSelected.isEmpty
                          ? SizeConfig.horizontal(14)
                          : null,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(2))),
                      color: AppColors.white,
                      border: Border.all(width: SizeConfig.horizontal(0.2))),
                  child: homeServiceManagerController.specialistSelected.isEmpty
                      ? Center(
                          child: Obx(
                            () => homeServiceManagerController
                                    .isLoadingBrands.isTrue
                                ? const CircularProgressIndicator()
                                : InterTextView(
                                    value: 'No Specialist Selected',
                                    color: AppColors.greyDisabled,
                                  ),
                          ),
                        )
                      : SizedBox(
                          height: SizeConfig.horizontal(40),
                          child: Padding(
                              padding: EdgeInsets.all(SizeConfig.horizontal(4)),
                              child: Scrollbar(
                                thumbVisibility: true,
                                interactive: true,
                                controller: homeServiceManagerController
                                    .specialistScrollbar,
                                child: ListView.builder(
                                  controller: homeServiceManagerController
                                      .specialistScrollbar,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: homeServiceManagerController
                                      .specialistSelected.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          InterTextView(
                                    value:
                                        '-${homeServiceManagerController.specialistSelected[index].brand}',
                                    color: AppColors.black,
                                  ),
                                ),
                              )),
                        ),
                )))
      ],
    );
  }

  Obx addressBoxWrapper(MapsController mapsController,
      HomeServiceManagerController homeServiceManagerController) {
    return Obx(
      () => ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: InterTextView(
                  value: mapsController.lat.isEmpty
                      ? 'Dapatkan Lokasi'
                      : 'Berikan rincian pada titik',
                  color: AppColors.black,
                  size: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.w500)),
          ResponsiveRowColumnItem(
            child: mapsController.lat.isEmpty
                ? CustomRippleButton(
                    borderRadius: BorderRadius.zero,
                    onTap: () => mapsController.getCoordinateUser(),
                    child: Container(
                        width: SizeConfig.horizontal(80),
                        height: SizeConfig.horizontal(14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeConfig.horizontal(2))),
                            color: AppColors.white,
                            border:
                                Border.all(width: SizeConfig.horizontal(0.2))),
                        child: Center(
                          child: Obx(
                            () => mapsController.isLoadingGetCoordinate.isTrue
                                ? const CircularProgressIndicator()
                                : InterTextView(
                                    value: 'Tap di sini',
                                    size: SizeConfig.safeBlockHorizontal * 3.5,
                                    color: AppColors.black),
                          ),
                        )))
                : ResponsiveRowColumnItem(
                    child: CustomTextField(
                        textAlignVertical: TextAlignVertical.top,
                        expands: true,
                        height: SizeConfig.horizontal(20),
                        width: 80,
                        borderRadius: 2,
                        hintText: 'contoh:5m dari masjid At-taqwa',
                        title: '',
                        controller: homeServiceManagerController.hsAddress),
                  ),
          )
        ],
      ),
    );
  }

  ResponsiveRowColumn _brandsBox(
      HomeServiceManagerController homeServiceManagerController) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: homeServiceManagerController.selectedBrandWrapper(),
                color: AppColors.black,
                size: SizeConfig.safeBlockHorizontal * 4,
                fontWeight: FontWeight.w500)),
        ResponsiveRowColumnItem(
            child: CustomRippleButton(
                borderRadius: BorderRadius.zero,
                onTap: () => homeServiceManagerController.verifyBrands(),
                child: Container(
                  width: SizeConfig.horizontal(80),
                  height: homeServiceManagerController.selectedBrand.isEmpty
                      ? SizeConfig.horizontal(14)
                      : null,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(2))),
                      color: AppColors.white,
                      border: Border.all(width: SizeConfig.horizontal(0.2))),
                  child: homeServiceManagerController.selectedBrand.isEmpty
                      ? Center(
                          child: Obx(
                            () => homeServiceManagerController
                                    .isLoadingBrands.isTrue
                                ? const CircularProgressIndicator()
                                : InterTextView(
                                    value: 'No Brand Selected',
                                    color: AppColors.greyDisabled,
                                  ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(SizeConfig.horizontal(4)),
                          child: Wrap(
                            spacing: SizeConfig.horizontal(2),
                            runSpacing: SizeConfig.horizontal(2),
                            children: homeServiceManagerController.selectedBrand
                                .map(
                                  (BrandsCarModel item) => CachedNetworkImage(
                                    width: SizeConfig.horizontal(10),
                                    height: SizeConfig.horizontal(10),
                                    imageUrl: item.brandImage,
                                    memCacheHeight: 300,
                                    memCacheWidth: 300,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                )))
      ],
    );
  }

  ResponsiveRowColumn _dropdown(BuildContext context,
      HomeServiceManagerController homeServiceManagerController) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: 'Jenis Kendaraan',
                color: AppColors.black,
                size: SizeConfig.safeBlockHorizontal * 4,
                fontWeight: FontWeight.w500)),
        ResponsiveRowColumnItem(
            child: CustomRippleButton(
                borderRadius: BorderRadius.zero,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: SizeConfig.horizontal(40),
                      width: SizeConfig.screenWidth,
                      child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnMainAxisAlignment: MainAxisAlignment.center,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: CustomDividerText(
                            useArrowIcon: false,
                            isCenter: false,
                            icon: Icons.motorcycle_rounded,
                            title: 'Motor',
                            textSize: 5,
                            onTap: () {
                              Get.back();
                              homeServiceManagerController
                                  .getBrands('brands_bike');
                              homeServiceManagerController
                                  .getSpecialist('specialist_bikecycle');
                            },
                          )),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                          ResponsiveRowColumnItem(
                              child: CustomDividerText(
                            useArrowIcon: false,
                            isCenter: false,
                            title: 'Mobil',
                            icon: Icons.minor_crash_rounded,
                            textSize: 5,
                            onTap: () {
                              Get.back();
                              homeServiceManagerController
                                  .getBrands('brands_car');
                              homeServiceManagerController
                                  .getSpecialist('specialist_automobile');
                            },
                          ))
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                    width: SizeConfig.horizontal(80),
                    height: SizeConfig.horizontal(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(SizeConfig.horizontal(2))),
                        color: AppColors.white,
                        border: Border.all(width: SizeConfig.horizontal(0.2))),
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.ROW,
                      rowMainAxisSize: MainAxisSize.min,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      rowPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.horizontal(2)),
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                            child: Obx(
                          () => InterTextView(
                            value: homeServiceManagerController
                                        .selectedDropDownMenu.value ==
                                    ''
                                ? 'No Selected'
                                : homeServiceManagerController
                                    .selectedDropDownMenu.value,
                            color: homeServiceManagerController
                                        .selectedDropDownMenu.value !=
                                    ''
                                ? AppColors.black
                                : AppColors.greyDisabled,
                          ),
                        )),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(horizontal: 1)),
                        ResponsiveRowColumnItem(
                            child: homeServiceManagerController
                                        .selectedDropDownMenu.value !=
                                    ''
                                ? const SizedBox.shrink()
                                : Icon(Icons.arrow_drop_down,
                                    color: AppColors.blackBackground,
                                    size: 34)),
                      ],
                    )))),
      ],
    );
  }

  Obx _mapImageWrapper(MapsController mapsController) {
    return Obx(
      () => mapsController.lat.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
              child: CustomRippleButton(
                onTap: () => mapsController.openGoogleMap(
                    mapsController.lat.value, mapsController.long.value),
                child: SizedBox(
                  width: SizeConfig.horizontal(80),
                  height: SizeConfig.horizontal(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(2))),
                    child: Image.asset(
                      AssetList.trashMap,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class HomeServicePictureWidget extends StatelessWidget {
  const HomeServicePictureWidget({
    super.key,
    required this.homeServiceManagerController,
  });
  final HomeServiceManagerController homeServiceManagerController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(20))),
          border: Border.all(
              width: SizeConfig.horizontal(1), color: AppColors.blueDark)),
      width: SizeConfig.horizontal(30),
      height: SizeConfig.horizontal(30),
      child: Stack(
        children: <Widget>[
          // ignore: prefer_if_elements_to_conditional_expressions
          homeServiceManagerController.workshopImage == null
              ? const CircleAvatar(child: Icon(Icons.home))
              : SizedBox(
                  width: SizeConfig.horizontal(30),
                  height: SizeConfig.horizontal(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(40))),
                    child: Image.file(
                      homeServiceManagerController.workshopImage!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: EdgeInsets.only(right: SizeConfig.horizontal(2)),
                  decoration: BoxDecoration(
                      color: AppColors.blackBackground,
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(20)))),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              backgroundColor: AppColors.blackBackground,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(SizeConfig.horizontal(4)),
                                child: ResponsiveRowColumn(
                                  layout: ResponsiveRowColumnType.COLUMN,
                                  columnMainAxisSize: MainAxisSize.min,
                                  children: <ResponsiveRowColumnItem>[
                                    const ResponsiveRowColumnItem(
                                        child: AutoBeresLogo(
                                            height: 20, width: 19)),
                                    const ResponsiveRowColumnItem(
                                        child: InterTextView(
                                            value:
                                                'Which menu do you want to upload from?',
                                            fontWeight: FontWeight.w500,
                                            alignText: AlignTextType.center)),
                                    const ResponsiveRowColumnItem(
                                        child: SpaceSizer(vertical: 2)),
                                    ResponsiveRowColumnItem(
                                        child: ResponsiveRowColumn(
                                      layout: ResponsiveRowColumnType.ROW,
                                      rowMainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      rowPadding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.horizontal(5)),
                                      columnSpacing: 8,
                                      children: <ResponsiveRowColumnItem>[
                                        ResponsiveRowColumnItem(
                                            child: CustomFlatButton(
                                                borderColor: AppColors.white,
                                                icon: Icons.image,
                                                iconSize: 50,
                                                colorIconImage: AppColors.white,
                                                radius: 1,
                                                width: 30,
                                                height: 15,
                                                text: '',
                                                backgroundColor:
                                                    AppColors.blackBackground,
                                                textColor: AppColors.white,
                                                onTap: () =>
                                                    homeServiceManagerController
                                                        .pickImage(ImageSource
                                                            .gallery))),
                                        ResponsiveRowColumnItem(
                                            child: CustomFlatButton(
                                                borderColor: AppColors.white,
                                                icon: Icons.camera_alt,
                                                iconSize: 50,
                                                colorIconImage: AppColors.white,
                                                radius: 1,
                                                width: 30,
                                                height: 15,
                                                text: '',
                                                backgroundColor:
                                                    AppColors.blackBackground,
                                                textColor: AppColors.white,
                                                onTap: () =>
                                                    homeServiceManagerController
                                                        .pickImage(ImageSource
                                                            .camera)))
                                      ],
                                    )),
                                    const ResponsiveRowColumnItem(
                                        child: SpaceSizer(vertical: 2)),
                                    ResponsiveRowColumnItem(
                                        child: Obx(
                                      () => CustomFlatButton(
                                          loading: homeServiceManagerController
                                              .isLoading.value,
                                          radius: 1,
                                          width: SizeConfig.horizontal(65),
                                          text: 'Cancel',
                                          backgroundColor: AppColors.redAlert,
                                          textColor: AppColors.white,
                                          onTap: () => Get.back()),
                                    )),
                                    const ResponsiveRowColumnItem(
                                        child: SpaceSizer(vertical: 1)),
                                  ],
                                ),
                              )),
                        );
                      },
                      icon: Icon(
                        Icons.edit_sharp,
                        size: 25,
                        color: AppColors.white,
                      ))))
        ],
      ),
    );
  }
}
