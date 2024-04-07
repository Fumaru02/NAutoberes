import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../domain/models/brands_car_model.dart';
import '../../../blocs/home_service_manager/home_service_manager_bloc.dart';
import '../../../cubits/home_service_manager/home_service_manager_cubit.dart';
import '../../../widgets/custom/custom_flat_button.dart';
import '../../../widgets/custom/custom_ripple_button.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../../../widgets/frame/frame_scaffold.dart';
import '../../../widgets/text/inter_text_view.dart';

class SelectBrands extends StatelessWidget {
  const SelectBrands({
    super.key,
    required this.brandlistCar,
  });
  final List<BrandsCarModel> brandlistCar;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
          heightBar: 60,
          isUseLeading: true,
          titleScreen: 'Select Brand',
          onBack: () => router.pop(),
          isCenter: true,
          elevation: 0,
          color: AppColors.blackBackground,
          statusBarColor: AppColors.blackBackground,
          colorScaffold: AppColors.white,
          statusBarBrightness: Brightness.light,
          view: BlocBuilder<HomeServiceManagerCubit,
              HomeServiceManagerStateCubit>(
            builder: (_, HomeServiceManagerStateCubit state) {
              return BlocBuilder<HomeServiceManagerBloc,
                  HomeServiceManagerState>(
                builder: (_, HomeServiceManagerState homeState) {
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
                                    hintText: 'Masukkan nama brand...',
                                    prefixIcon: const Icon(Icons.search),
                                    onChanged: (String p0) {
                                      _.read<HomeServiceManagerBloc>().add(
                                          OnSearchBrand(
                                              query: p0,
                                              brandsList: brandlistCar));
                                    },
                                    title: '')),
                            ResponsiveRowColumnItem(
                                child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.horizontal(10)),
                              itemCount: homeState.foundedBrand.isEmpty
                                  ? brandlistCar.length
                                  : homeState.foundedBrand.length,
                              itemBuilder: (BuildContext context, int index) {
                                final BrandsCarModel item = brandlistCar[index];
                                final bool isSelected =
                                    state.selectedBrand.contains(item);
                                return CustomRippleButton(
                                  borderRadius: BorderRadius.zero,
                                  onTap: () => _
                                      .read<HomeServiceManagerCubit>()
                                      .toggleSelectionBrand(item),
                                  child: listTileBrands(
                                      homeState.foundedBrand.isNotEmpty
                                          ? homeState.foundedBrand[index]
                                          : brandlistCar[index],
                                      isSelected),
                                );
                              },
                            ))
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
                              text: 'Selected (${state.selectedBrand.length})',
                              onTap: () {
                                _.read<HomeServiceManagerBloc>().add(
                                    OnUploadHandledBrands(
                                        dataHandled: state.selectedBrand));
                              }),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ));
  }

  Widget listTileBrands(BrandsCarModel model, bool isSelected) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.horizontal(0.5)),
      child: ListTile(
        tileColor: isSelected == true ? AppColors.blackBackground : null,
        title: InterTextView(
          value: model.brand,
          color: AppColors.black,
        ),
        leading: CachedNetworkImage(
          width: SizeConfig.horizontal(10),
          height: SizeConfig.horizontal(10),
          imageUrl: model.brandImage,
          memCacheHeight: 100,
          memCacheWidth: 100,
        ),
      ),
    );
  }
}
