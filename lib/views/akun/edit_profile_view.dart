import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/akun_controller.dart';
import '../../controllers/edit_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_confirmation_dialog.dart';
import '../widgets/custom/custom_flat_button.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/roboto_text_view.dart';
import '../widgets/user/user_info.dart';
import 'akun_view.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

final AkunController akunController = Get.put(AkunController());
EditController editController = Get.put(EditController());

class _EditProfileViewState extends State<EditProfileView> {
  @override
  void initState() {
    editController.usernameTextEditingController =
        TextEditingController(text: akunController.username.value);
    editController.descriptionTextEditingController =
        TextEditingController(text: akunController.userDescription.value);
    super.initState();
  }

  @override
  void dispose() {
    editController.usernameTextEditingController.dispose();
    editController.descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.black,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: GetBuilder<EditController>(
          init: EditController(),
          builder: (EditController editController) => FrameScaffold(
              heightBar: 60,
              isUseLeading: true,
              titleScreen: 'Edit Profile',
              elevation: 0,
              color: Platform.isIOS ? AppColors.black : null,
              statusBarColor: AppColors.black,
              colorScaffold: Colors.grey[200],
              statusBarBrightness: Brightness.light,
              view: SingleChildScrollView(
                child: Center(
                  child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.COLUMN,
                      children: <ResponsiveRowColumnItem>[
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 1.5)),
                        ResponsiveRowColumnItem(
                            child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.horizontal(20))),
                              border: Border.all(
                                  width: SizeConfig.horizontal(1),
                                  color: AppColors.orangeActive)),
                          width: SizeConfig.horizontal(30),
                          height: SizeConfig.horizontal(30),
                          child: Stack(
                            children: <Widget>[
                              const UserPicture(size: 40),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.horizontal(2)),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.horizontal(20)))),
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Dialog(
                                                  backgroundColor:
                                                      AppColors.blackBackground,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        SizeConfig.horizontal(
                                                            4)),
                                                    child: ResponsiveRowColumn(
                                                      layout:
                                                          ResponsiveRowColumnType
                                                              .COLUMN,
                                                      columnMainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <ResponsiveRowColumnItem>[
                                                        const ResponsiveRowColumnItem(
                                                            child:
                                                                AutoBeresLogo(
                                                          height: 20,
                                                          width: 19,
                                                        )),
                                                        const ResponsiveRowColumnItem(
                                                            child:
                                                                RobotoTextView(
                                                          value:
                                                              'Which menu do you want to upload from?',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          alignText:
                                                              AlignTextType
                                                                  .center,
                                                        )),
                                                        const ResponsiveRowColumnItem(
                                                            child: SpaceSizer(
                                                          vertical: 2,
                                                        )),
                                                        ResponsiveRowColumnItem(
                                                            child:
                                                                ResponsiveRowColumn(
                                                          layout:
                                                              ResponsiveRowColumnType
                                                                  .ROW,
                                                          rowMainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          rowPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      SizeConfig
                                                                          .horizontal(
                                                                              5)),
                                                          columnSpacing: 8,
                                                          children: <ResponsiveRowColumnItem>[
                                                            ResponsiveRowColumnItem(
                                                                child:
                                                                    CustomFlatButton(
                                                              borderColor:
                                                                  AppColors
                                                                      .white,
                                                              icon: Icons.image,
                                                              iconSize: 50,
                                                              colorIconImage:
                                                                  AppColors
                                                                      .white,
                                                              radius: 1,
                                                              width: SizeConfig
                                                                  .horizontal(
                                                                      25),
                                                              height: SizeConfig
                                                                  .horizontal(
                                                                      25),
                                                              text: '',
                                                              backgroundColor:
                                                                  AppColors
                                                                      .blackBackground,
                                                              textColor:
                                                                  AppColors
                                                                      .white,
                                                              onTap: () =>
                                                                  editController
                                                                      .pickImageFromGallery(),
                                                            )),
                                                            ResponsiveRowColumnItem(
                                                                child:
                                                                    CustomFlatButton(
                                                              borderColor:
                                                                  AppColors
                                                                      .white,
                                                              icon: Icons
                                                                  .camera_alt,
                                                              iconSize: 50,
                                                              colorIconImage:
                                                                  AppColors
                                                                      .white,
                                                              radius: 1,
                                                              width: SizeConfig
                                                                  .horizontal(
                                                                      25),
                                                              height: SizeConfig
                                                                  .horizontal(
                                                                      25),
                                                              text: '',
                                                              backgroundColor:
                                                                  AppColors
                                                                      .blackBackground,
                                                              textColor:
                                                                  AppColors
                                                                      .white,
                                                              onTap: () =>
                                                                  editController
                                                                      .pickImageFromCamera(),
                                                            ))
                                                          ],
                                                        )),
                                                        const ResponsiveRowColumnItem(
                                                            child: SpaceSizer(
                                                                vertical: 2)),
                                                        ResponsiveRowColumnItem(
                                                            child: CustomFlatButton(
                                                                radius: 1,
                                                                width: SizeConfig
                                                                    .horizontal(
                                                                        65),
                                                                text: 'Cancel',
                                                                backgroundColor:
                                                                    AppColors
                                                                        .redAlert,
                                                                textColor:
                                                                    AppColors
                                                                        .white,
                                                                onTap: () => Get
                                                                    .back())),
                                                        const ResponsiveRowColumnItem(
                                                            child: SpaceSizer(
                                                                vertical: 1)),
                                                      ],
                                                    ),
                                                  )),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit_sharp,
                                        size: 25,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 0.5)),
                        ResponsiveRowColumnItem(
                            child: UserStatus(
                                size: 8,
                                height: SizeConfig.horizontal(8),
                                width: SizeConfig.horizontal(20))),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 0.5)),
                        ResponsiveRowColumnItem(
                            child: RobotoTextView(
                                value: akunController.userEmail.value,
                                color: AppColors.black)),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 2)),
                        ResponsiveRowColumnItem(
                            child: CustomTextField(
                                height: 7,
                                controller: editController
                                    .usernameTextEditingController,
                                textInputAction: TextInputAction.done,
                                hintTextColor: AppColors.black,
                                title: 'Username',
                                onChanged: (String value) {
                                  editController.usernameTextEditingController
                                      .text = value.trim();
                                },
                                textColor: AppColors.black,
                                labelText:
                                    akunController.username.value.trim())),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 0.5)),
                        ResponsiveRowColumnItem(
                            child: ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.COLUMN,
                          columnCrossAxisAlignment: CrossAxisAlignment.start,
                          children: <ResponsiveRowColumnItem>[
                            ResponsiveRowColumnItem(
                                child: RobotoTextView(
                                    value: 'Gender',
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
                                      height: SizeConfig.horizontal(45),
                                      width: SizeConfig.screenWidth,
                                      child: ResponsiveRowColumn(
                                        layout: ResponsiveRowColumnType.COLUMN,
                                        children: <ResponsiveRowColumnItem>[
                                          ResponsiveRowColumnItem(
                                              child: CustomDividerText(
                                                  useArrowIcon: false,
                                                  isCenter: false,
                                                  title: 'MALE',
                                                  textSize: 6,
                                                  iconColor:
                                                      AppColors.blueColor,
                                                  iconSize: 50,
                                                  onTap: () {
                                                    akunController.userGender
                                                        .value = 'male';
                                                    Get.back();
                                                  },
                                                  icon: Icons.male)),
                                          ResponsiveRowColumnItem(
                                              child: CustomDividerText(
                                                  useArrowIcon: false,
                                                  isCenter: false,
                                                  title: 'FEMALE',
                                                  textSize: 6,
                                                  iconSize: 50,
                                                  iconColor:
                                                      AppColors.pinkColor,
                                                  onTap: () {
                                                    akunController.userGender
                                                        .value = 'female';
                                                    Get.back();
                                                  },
                                                  icon: Icons.female))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: SizeConfig.horizontal(90),
                                  height: SizeConfig.horizontal(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.horizontal(1))),
                                      color: AppColors.white,
                                      border: Border.all(
                                          width: SizeConfig.horizontal(0.2))),
                                  child: ResponsiveRowColumn(
                                    layout: ResponsiveRowColumnType.ROW,
                                    rowPadding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.horizontal(2)),
                                    children: <ResponsiveRowColumnItem>[
                                      ResponsiveRowColumnItem(
                                          child: Obx(
                                        () => akunController.userGender.value ==
                                                'male'
                                            ? Icon(
                                                Icons.male,
                                                color: AppColors.blueColor,
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.female,
                                                color: AppColors.pinkColor,
                                                size: 30,
                                              ),
                                      )),
                                      const ResponsiveRowColumnItem(
                                          child: SpaceSizer(
                                        horizontal: 1,
                                      )),
                                      ResponsiveRowColumnItem(
                                          child: Obx(() => RobotoTextView(
                                              value: akunController
                                                  .userGender.value
                                                  .toUpperCase(),
                                              color: AppColors.black,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.w500))),
                                      const ResponsiveRowColumnItem(
                                          child: Spacer()),
                                      ResponsiveRowColumnItem(
                                          child: Icon(
                                              Icons.arrow_drop_down_circle,
                                              color: AppColors.black,
                                              size: 30)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                        ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            columnCrossAxisAlignment: CrossAxisAlignment.start,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: RobotoTextView(
                                      value: 'Profiency',
                                      color: AppColors.black,
                                      size: SizeConfig.safeBlockHorizontal * 4,
                                      fontWeight: FontWeight.w500)),
                              ResponsiveRowColumnItem(
                                child: CustomRippleButton(
                                  borderRadius: BorderRadius.zero,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          SizedBox(
                                              height: SizeConfig.horizontal(70),
                                              width: SizeConfig.screenWidth,
                                              child: ListView.builder(
                                                  itemCount: editController
                                                      .profiencyList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          RobotoTextView(
                                                            value: editController
                                                                .profiencyList[
                                                                    index]
                                                                .name,
                                                            color:
                                                                AppColors.black,
                                                          ))),
                                    );
                                  },
                                  child: Container(
                                    width: SizeConfig.horizontal(90),
                                    height: SizeConfig.horizontal(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                SizeConfig.horizontal(1))),
                                        color: AppColors.white,
                                        border: Border.all(
                                            width: SizeConfig.horizontal(0.2))),
                                    child: ResponsiveRowColumn(
                                      layout: ResponsiveRowColumnType.ROW,
                                      rowPadding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.horizontal(2)),
                                      children: <ResponsiveRowColumnItem>[
                                        ResponsiveRowColumnItem(
                                          child: Icon(
                                            Icons.location_on,
                                            color: AppColors.redAlert,
                                            size: 30,
                                          ),
                                        ),
                                        const ResponsiveRowColumnItem(
                                            child: SpaceSizer(
                                          horizontal: 1,
                                        )),
                                        ResponsiveRowColumnItem(
                                            child: RobotoTextView(
                                                value: 'Jawa Barat',
                                                color: AppColors.black,
                                                size: SizeConfig
                                                        .safeBlockHorizontal *
                                                    3.5,
                                                fontWeight: FontWeight.w500)),
                                        const ResponsiveRowColumnItem(
                                            child: Spacer()),
                                        ResponsiveRowColumnItem(
                                            child: Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: AppColors.black,
                                                size: 30)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            columnCrossAxisAlignment: CrossAxisAlignment.start,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: RobotoTextView(
                                      value: 'City',
                                      color: AppColors.black,
                                      size: SizeConfig.safeBlockHorizontal * 4,
                                      fontWeight: FontWeight.w500)),
                              ResponsiveRowColumnItem(
                                child: CustomRippleButton(
                                  borderRadius: BorderRadius.zero,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          SizedBox(
                                        height: SizeConfig.horizontal(45),
                                        width: SizeConfig.screenWidth,
                                        child: ResponsiveRowColumn(
                                          layout:
                                              ResponsiveRowColumnType.COLUMN,
                                          children: <ResponsiveRowColumnItem>[
                                            ResponsiveRowColumnItem(
                                                child: CustomDividerText(
                                                    useArrowIcon: false,
                                                    isCenter: false,
                                                    title: 'MALE',
                                                    textSize: 6,
                                                    iconColor:
                                                        AppColors.blueColor,
                                                    iconSize: 50,
                                                    onTap: () {
                                                      akunController.userGender
                                                          .value = 'male';
                                                      Get.back();
                                                    },
                                                    icon: Icons.male)),
                                            ResponsiveRowColumnItem(
                                                child: CustomDividerText(
                                                    useArrowIcon: false,
                                                    isCenter: false,
                                                    title: 'FEMALE',
                                                    textSize: 6,
                                                    iconSize: 50,
                                                    iconColor:
                                                        AppColors.pinkColor,
                                                    onTap: () {
                                                      akunController.userGender
                                                          .value = 'female';
                                                      Get.back();
                                                    },
                                                    icon: Icons.female))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: SizeConfig.horizontal(90),
                                    height: SizeConfig.horizontal(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                SizeConfig.horizontal(1))),
                                        color: AppColors.white,
                                        border: Border.all(
                                            width: SizeConfig.horizontal(0.2))),
                                    child: ResponsiveRowColumn(
                                      layout: ResponsiveRowColumnType.ROW,
                                      rowPadding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.horizontal(2)),
                                      children: <ResponsiveRowColumnItem>[
                                        const ResponsiveRowColumnItem(
                                            child: Icon(
                                          Icons.location_city,
                                          size: 30,
                                        )),
                                        const ResponsiveRowColumnItem(
                                            child: SpaceSizer(
                                          horizontal: 1,
                                        )),
                                        ResponsiveRowColumnItem(
                                            child: RobotoTextView(
                                                value: 'Kota Bekasi',
                                                color: AppColors.black,
                                                size: SizeConfig
                                                        .safeBlockHorizontal *
                                                    3.5,
                                                fontWeight: FontWeight.w500)),
                                        const ResponsiveRowColumnItem(
                                            child: Spacer()),
                                        ResponsiveRowColumnItem(
                                            child: Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: AppColors.black,
                                                size: 30)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 0.5)),
                        ResponsiveRowColumnItem(
                            child: CustomTextField(
                          controller:
                              editController.descriptionTextEditingController,
                          height: 20,
                          textInputAction: TextInputAction.done,
                          hintTextColor: AppColors.black,
                          title: 'Description',
                          textColor: AppColors.black,
                          contentPadding:
                              EdgeInsets.all(SizeConfig.horizontal(2)),
                          textAlignVertical: TextAlignVertical.top,
                          labelText: akunController.userDescription.value,
                          onChanged: (String value) {
                            editController
                                .descriptionTextEditingController.text = value;
                          },
                        )),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 2)),
                        ResponsiveRowColumnItem(
                            child: CustomFlatButton(
                          text: 'Submit',
                          textColor: AppColors.black,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomConfirmationDialog(
                                onConfirm: () {},
                                title: 'do you want save your current changes?',
                                cancelText: 'Cancel',
                                confirmText: 'Confirm',
                              ),
                            );
                          },
                        )),
                      ]),
                ),
              )),
        ));
  }
}
