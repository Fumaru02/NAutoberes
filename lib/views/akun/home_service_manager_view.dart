import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/home_service_manager_controller.dart';
import '../../controllers/maps_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../home/home_menu/ganti_oli_view.dart';
import '../widgets/custom/custom_flat_button.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/inter_text_view.dart';
import 'akun_view.dart';
import 'widgets/select_cars.dart';

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
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.ROW,
                                rowMainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                    child: CustomTextField(
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        expands: true,
                                        height: SizeConfig.horizontal(20),
                                        width: 60,
                                        borderRadius: 2,
                                        hintText:
                                            'contoh:5m dari masjid At-taqwa',
                                        title: 'Berikan Details alamat',
                                        controller: homeServiceManagerController
                                            .hsAddress),
                                  ),
                                  ResponsiveRowColumnItem(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.horizontal(4)),
                                    child: Obx(
                                      () => CustomFlatButton(
                                          width: 12,
                                          height: 6,
                                          loading:
                                              mapsController.isLoading.value,
                                          text: '',
                                          icon:
                                              Icons.location_searching_rounded,
                                          colorIconImage: AppColors.white,
                                          onTap: () => mapsController
                                              .getCoordinateUser()),
                                    ),
                                  )),
                                ],
                              )),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child: _dropdown(context)),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child:
                                      _brandsBox(homeServiceManagerController)),
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
                                      '*Pastikan kamu sudah mengetap icon biru diatas',
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
                                    onTap: () =>
                                        homeServiceManagerController.onConfirm(
                                            mapsController.lat.value,
                                            mapsController.long.value)),
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

  ResponsiveRowColumn _brandsBox(
      HomeServiceManagerController homeServiceManagerController) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: 'Pilih brand yang kamu kuasai',
                color: AppColors.black,
                size: SizeConfig.safeBlockHorizontal * 4,
                fontWeight: FontWeight.w500)),
        ResponsiveRowColumnItem(
            child: CustomRippleButton(
                borderRadius: BorderRadius.zero,
                onTap: () => Get.to(const SelectCars()),
                child: Container(
                    width: SizeConfig.horizontal(80),
                    height: SizeConfig.horizontal(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(SizeConfig.horizontal(2))),
                        color: AppColors.white,
                        border: Border.all(width: SizeConfig.horizontal(0.2))),
                    child: Center(
                      child: InterTextView(
                        value: 'No Brand Selected',
                        color: AppColors.greyDisabled,
                      ),
                    )))),
      ],
    );
  }

  ResponsiveRowColumn _dropdown(BuildContext context) {
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
                            title: 'Motor',
                            textSize: 5,
                            onTap: () {
                              Get.back();
                            },
                          )),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                          ResponsiveRowColumnItem(
                              child: CustomDividerText(
                            useArrowIcon: false,
                            isCenter: false,
                            title: 'Mobil',
                            textSize: 5,
                            onTap: () {
                              Get.back();
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
                      rowPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.horizontal(2)),
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                            child: InterTextView(
                          value: 'No Selected',
                          color: AppColors.greyDisabled,
                        )),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(horizontal: 1)),
                        const ResponsiveRowColumnItem(child: Spacer()),
                        ResponsiveRowColumnItem(
                            child: Icon(Icons.arrow_drop_down,
                                color: AppColors.blackBackground, size: 34)),
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
                  width: SizeConfig.horizontal(50),
                  height: SizeConfig.horizontal(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(6))),
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
