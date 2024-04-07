import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/constant/enums.dart';
import '../../../core/helpers/snackbar.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/asset_list.dart';
import '../../../core/utils/size_config.dart';
import '../../../domain/models/brands_car_model.dart';
import '../../blocs/home_service_manager/home_service_manager_bloc.dart';
import '../../blocs/maps/maps_bloc.dart';
import '../../cubits/home_service_manager/home_service_manager_cubit.dart';
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

class HomeServiceManagerView extends StatefulWidget {
  const HomeServiceManagerView({super.key});

  @override
  State<HomeServiceManagerView> createState() => _HomeServiceManagerViewState();
}

class _HomeServiceManagerViewState extends State<HomeServiceManagerView> {
  final TextEditingController homeServiceNameController =
      TextEditingController();
  final TextEditingController homeServiceAddress = TextEditingController();
  final TextEditingController homeServiceSkill = TextEditingController();
  final ScrollController specialistScrollController = ScrollController();

  @override
  void dispose() {
    homeServiceAddress.dispose();
    homeServiceNameController.dispose();
    specialistScrollController.dispose();
    homeServiceSkill.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          view: SingleChildScrollView(
            child: Consumer<ScreenHeight>(
              builder:
                  (BuildContext context, ScreenHeight res, Widget? child) =>
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
                                : const HomeServicePictureWidget()),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 2)),
                        ResponsiveRowColumnItem(
                            child: CustomTextField(
                          borderRadius: 2,
                          title: 'Nama Usaha Individu Service',
                          hintText: 'contoh:Rian Motor',
                          controller: homeServiceNameController,
                        )),
                        ResponsiveRowColumnItem(
                            child: res.isOpen
                                ? const SizedBox.shrink()
                                : _mapImageWrapper()),
                        ResponsiveRowColumnItem(
                            child: addressBoxWrapper(homeServiceAddress)),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 1)),
                        ResponsiveRowColumnItem(
                            child: BlocBuilder<MapsBloc, MapsState>(
                          builder: (_, MapsState state) {
                            return state.lat.isEmpty
                                ? const SizedBox.shrink()
                                : _dropdown();
                          },
                        )),
                        ResponsiveRowColumnItem(child: BlocBuilder<
                            HomeServiceManagerBloc, HomeServiceManagerState>(
                          builder: (_, HomeServiceManagerState homeState) {
                            return homeState.selectedDropDownMenu == ''
                                ? const SizedBox.shrink()
                                : _brandsBox(homeState);
                          },
                        )),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 1)),
                        ResponsiveRowColumnItem(child: BlocBuilder<
                            HomeServiceManagerBloc, HomeServiceManagerState>(
                          builder: (_, HomeServiceManagerState homeState) {
                            return homeState.selectedDropDownMenu == ''
                                ? const SizedBox.shrink()
                                : _specialistsBox(
                                    homeState, specialistScrollController);
                          },
                        )),
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
                                controller: homeServiceSkill)),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(vertical: 5)),
                        ResponsiveRowColumnItem(
                            child: Padding(
                          padding:
                              EdgeInsets.only(right: SizeConfig.horizontal(8)),
                          child: InterTextView(
                            value:
                                '*Pastikan kamu sudah mengisi alamat lengkap',
                            size: SizeConfig.safeBlockHorizontal * 3,
                            color: AppColors.redAlert,
                          ),
                        )),
                        ResponsiveRowColumnItem(
                            child: BlocBuilder<MapsBloc, MapsState>(
                          builder: (_, MapsState state) {
                            return CustomFlatButton(
                                text: 'Confirm',
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => BlocBuilder<
                                              HomeServiceManagerCubit,
                                              HomeServiceManagerStateCubit>(
                                            builder: (_,
                                                HomeServiceManagerStateCubit
                                                    homeCubitState) {
                                              return CustomConfirmationDialog(
                                                  title: 'kamu yakin?',
                                                  confirmText: 'Selesai',
                                                  cancelText: 'Kembali',
                                                  onConfirm: () => _
                                                      .read<
                                                          HomeServiceManagerBloc>()
                                                      .add(OnConfirm(
                                                          lat: state.lat,
                                                          long: state.long,
                                                          homeServiceName: homeServiceAddress
                                                              .text
                                                              .trim(),
                                                          homeServiceSkill:
                                                              homeServiceSkill
                                                                  .text
                                                                  .trim(),
                                                          homeServiceAddress:
                                                              homeServiceAddress
                                                                  .text
                                                                  .trim(),
                                                          workshopImage:
                                                              homeCubitState
                                                                  .workshopImage!)));
                                            },
                                          ));
                                });
                          },
                        ))
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        )));
  }

  Widget _specialistsBox(
      HomeServiceManagerState homeState, ScrollController scrollController) {
    return BlocBuilder<HomeServiceManagerCubit, HomeServiceManagerStateCubit>(
      builder: (_, HomeServiceManagerStateCubit state) {
        return ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
                child: InterTextView(
                    value: state.selectedSpecialist.isEmpty
                        ? 'Pilih specialis yang kamu kuasai'
                        : 'specialis yang kamu kuasai',
                    color: AppColors.black,
                    size: SizeConfig.safeBlockHorizontal * 4,
                    fontWeight: FontWeight.w500)),
            ResponsiveRowColumnItem(
                child: CustomRippleButton(
                    borderRadius: BorderRadius.zero,
                    onTap: () => homeState.selectedDropDownMenu.isEmpty
                        ? Snack.showSnackBar(context,
                            messageInfo: 'Something wrong',
                            message: 'Jenis Kendaraan tidak boleh kosong',
                            snackbarType: SnackbarType.error)
                        : router.push('/selectspecialist',
                            extra: homeState.specialistList),
                    child: Container(
                      width: SizeConfig.horizontal(80),
                      height: state.selectedSpecialist.isEmpty
                          ? SizeConfig.horizontal(14)
                          : null,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(SizeConfig.horizontal(2))),
                          color: AppColors.white,
                          border:
                              Border.all(width: SizeConfig.horizontal(0.2))),
                      child: state.selectedSpecialist.isEmpty
                          ? Center(
                              child: homeState.homeServiceStatus ==
                                      HomeServiceStatus.loading
                                  ? const CircularProgressIndicator()
                                  : InterTextView(
                                      value: 'No Specialist Selected',
                                      color: AppColors.greyDisabled,
                                    ),
                            )
                          : SizedBox(
                              height: SizeConfig.horizontal(40),
                              child: Padding(
                                  padding:
                                      EdgeInsets.all(SizeConfig.horizontal(4)),
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    interactive: true,
                                    controller: scrollController,
                                    child: ListView.builder(
                                      controller: scrollController,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          state.selectedSpecialist.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              InterTextView(
                                        value:
                                            '-${state.selectedSpecialist[index].brand}',
                                        color: AppColors.black,
                                      ),
                                    ),
                                  )),
                            ),
                    )))
          ],
        );
      },
    );
  }

  Widget addressBoxWrapper(TextEditingController homeServiceAddress) {
    return BlocBuilder<MapsBloc, MapsState>(
      builder: (_, MapsState state) {
        return ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
                child: InterTextView(
                    value: state.lat.isEmpty
                        ? 'Dapatkan Lokasi'
                        : 'Berikan rincian pada titik',
                    color: AppColors.black,
                    size: SizeConfig.safeBlockHorizontal * 4,
                    fontWeight: FontWeight.w500)),
            ResponsiveRowColumnItem(
              child: state.lat.isEmpty
                  ? CustomRippleButton(
                      borderRadius: BorderRadius.zero,
                      onTap: () => _.read<MapsBloc>().add(GetCoordinateUser()),
                      child: Container(
                          width: SizeConfig.horizontal(80),
                          height: SizeConfig.horizontal(14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.horizontal(2))),
                              color: AppColors.white,
                              border: Border.all(
                                  width: SizeConfig.horizontal(0.2))),
                          child: Center(
                            child: state.mapsStatus == MapsStatus.loading
                                ? const CircularProgressIndicator()
                                : InterTextView(
                                    value: 'Tap di sini',
                                    size: SizeConfig.safeBlockHorizontal * 3.5,
                                    color: AppColors.black),
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
                          controller: homeServiceAddress),
                    ),
            )
          ],
        );
      },
    );
  }

  Widget _brandsBox(HomeServiceManagerState homeState) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: homeState.brandsList.isEmpty
                    ? 'Pilih brand yang kamu kuasai'
                    : 'Brand yang kamu kuasai',
                color: AppColors.black,
                size: SizeConfig.safeBlockHorizontal * 4,
                fontWeight: FontWeight.w500)),
        ResponsiveRowColumnItem(
            child: CustomRippleButton(
                borderRadius: BorderRadius.zero,
                onTap: () => homeState.selectedDropDownMenu.isEmpty
                    ? Snack.showSnackBar(context,
                        messageInfo: 'Something wrong',
                        message: 'Jenis Kendaraan tidak boleh kosong',
                        snackbarType: SnackbarType.error)
                    : router.push('/selectbrands', extra: homeState.brandsList),
                child: Container(
                  width: SizeConfig.horizontal(80),
                  height: homeState.getBrand.isEmpty
                      ? SizeConfig.horizontal(14)
                      : null,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(2))),
                      color: AppColors.white,
                      border: Border.all(width: SizeConfig.horizontal(0.2))),
                  child: homeState.getBrand.isEmpty
                      ? Center(
                          child: homeState.homeServiceStatus ==
                                  HomeServiceStatus.loading
                              ? const CircularProgressIndicator()
                              : InterTextView(
                                  value: 'No Brand Selected',
                                  color: AppColors.greyDisabled,
                                ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(SizeConfig.horizontal(4)),
                          child: Wrap(
                            spacing: SizeConfig.horizontal(2),
                            runSpacing: SizeConfig.horizontal(2),
                            children: homeState.getBrand
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

  ResponsiveRowColumn _dropdown() {
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
                    builder: (_) => BlocProvider<HomeServiceManagerCubit>.value(
                      value: context.read<HomeServiceManagerCubit>(),
                      child: SizedBox(
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
                                context
                                    .read<HomeServiceManagerBloc>()
                                    .add(const GetBrands(type: 'brands_bike'));
                                context.read<HomeServiceManagerBloc>().add(
                                    const GetSpecialist(
                                        type: 'specialist_bikecycle'));
                                router.pop();
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
                                context
                                    .read<HomeServiceManagerBloc>()
                                    .add(const GetBrands(type: 'brands_car'));
                                context.read<HomeServiceManagerBloc>().add(
                                    const GetSpecialist(
                                        type: 'specialist_automobile'));
                                router.pop();
                              },
                            ))
                          ],
                        ),
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
                    child: BlocBuilder<HomeServiceManagerBloc,
                        HomeServiceManagerState>(
                      builder: (_, HomeServiceManagerState state) {
                        return ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.ROW,
                          rowMainAxisSize: MainAxisSize.min,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          rowPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.horizontal(2)),
                          children: <ResponsiveRowColumnItem>[
                            ResponsiveRowColumnItem(
                              child: InterTextView(
                                value: state.selectedDropDownMenu == ''
                                    ? 'No Selected'
                                    : state.selectedDropDownMenu,
                                color: state.selectedDropDownMenu != ''
                                    ? AppColors.black
                                    : AppColors.greyDisabled,
                              ),
                            ),
                            const ResponsiveRowColumnItem(
                                child: SpaceSizer(horizontal: 1)),
                            ResponsiveRowColumnItem(
                                child: state.selectedDropDownMenu != ''
                                    ? const SizedBox.shrink()
                                    : Icon(Icons.arrow_drop_down,
                                        color: AppColors.blackBackground,
                                        size: 34)),
                          ],
                        );
                      },
                    )))),
      ],
    );
  }

  Widget _mapImageWrapper() {
    return BlocBuilder<MapsBloc, MapsState>(
      builder: (_, MapsState state) {
        return state.lat.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                child: CustomRippleButton(
                  onTap: () => context
                      .read<MapsBloc>()
                      .add(OpenMap(lat: state.lat, long: state.long)),
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
              );
      },
    );
  }
}

class HomeServicePictureWidget extends StatelessWidget {
  const HomeServicePictureWidget({
    super.key,
  });

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
      child:
          BlocConsumer<HomeServiceManagerCubit, HomeServiceManagerStateCubit>(
        listener: (_, HomeServiceManagerStateCubit state) {
          if (state.imageStatus == ImageStatus.failed) {
            Snack.showSnackBar(context,
                messageInfo: 'Something wrong',
                message: 'Failed to pick image please try again',
                snackbarType: SnackbarType.error);
          } else if (state.imageStatus == ImageStatus.success) {
            Snack.showSnackBar(context,
                messageInfo: 'Pick image Success',
                message: 'Image has been uploaded',
                snackbarType: SnackbarType.success);
          } else {
            const Center(child: CircularProgressIndicator());
          }
        },
        builder: (_, HomeServiceManagerStateCubit state) {
          return Stack(
            children: <Widget>[
              // ignore: prefer_if_elements_to_conditional_expressions
              state.workshopImage == null
                  ? const CircleAvatar(child: Icon(Icons.home))
                  : SizedBox(
                      width: SizeConfig.horizontal(30),
                      height: SizeConfig.horizontal(30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(SizeConfig.horizontal(40))),
                        child: Image.file(
                          state.workshopImage!,
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
                                    padding: EdgeInsets.all(
                                        SizeConfig.horizontal(4)),
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
                                                alignText:
                                                    AlignTextType.center)),
                                        const ResponsiveRowColumnItem(
                                            child: SpaceSizer(vertical: 2)),
                                        ResponsiveRowColumnItem(
                                            child: ResponsiveRowColumn(
                                          layout: ResponsiveRowColumnType.ROW,
                                          rowMainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          rowPadding: EdgeInsets.symmetric(
                                              horizontal:
                                                  SizeConfig.horizontal(5)),
                                          columnSpacing: 8,
                                          children: <ResponsiveRowColumnItem>[
                                            ResponsiveRowColumnItem(
                                                child: CustomFlatButton(
                                                    borderColor:
                                                        AppColors.white,
                                                    icon: Icons.image,
                                                    iconSize: 50,
                                                    colorIconImage:
                                                        AppColors.white,
                                                    radius: 1,
                                                    width: 30,
                                                    height: 15,
                                                    text: '',
                                                    backgroundColor: AppColors
                                                        .blackBackground,
                                                    textColor: AppColors.white,
                                                    onTap: () => _
                                                        .read<
                                                            HomeServiceManagerCubit>()
                                                        .pickImage(ImageSource
                                                            .gallery))),
                                            ResponsiveRowColumnItem(
                                                child: CustomFlatButton(
                                                    borderColor:
                                                        AppColors.white,
                                                    icon: Icons.camera_alt,
                                                    iconSize: 50,
                                                    colorIconImage:
                                                        AppColors.white,
                                                    radius: 1,
                                                    width: 30,
                                                    height: 15,
                                                    text: '',
                                                    backgroundColor: AppColors
                                                        .blackBackground,
                                                    textColor: AppColors.white,
                                                    onTap: () => _
                                                        .read<
                                                            HomeServiceManagerCubit>()
                                                        .pickImage(ImageSource
                                                            .camera)))
                                          ],
                                        )),
                                        const ResponsiveRowColumnItem(
                                            child: SpaceSizer(vertical: 2)),
                                        ResponsiveRowColumnItem(
                                          child: CustomFlatButton(
                                              radius: 1,
                                              width: SizeConfig.horizontal(65),
                                              text: 'Cancel',
                                              backgroundColor:
                                                  AppColors.redAlert,
                                              textColor: AppColors.white,
                                              onTap: () => router.pop()),
                                        ),
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
          );
        },
      ),
    );
  }
}
