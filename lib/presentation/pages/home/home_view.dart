import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/asset_list.dart';
import '../../../core/utils/size_config.dart';
import '../../blocs/bloc/home_bloc.dart';
import '../../cubits/home/home_cubit.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';
import 'widgets/automotive_news.dart';
import 'widgets/beresin_menu.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/promo_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final ScrollController scrollController = ScrollController();
final CarouselController carouselController = CarouselController();

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeBloc>().add(GetDataHome());
    context.read<HomeBloc>().add(GetPromo());
    context.read<HomeCubit>().updateGreating();
    scrollController.addListener(() {
      context.read<HomeCubit>().listen(scrollController);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollController.removeListener(() {
      context.read<HomeCubit>().listen(scrollController);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: CustomScrollView(controller: scrollController, slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: Stack(
                    children: <Widget>[
                      Container(
                        height: SizeConfig.horizontal(50),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AssetList.backgroundBubble),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(SizeConfig.horizontal(17)),
                              bottomRight:
                                  Radius.circular(SizeConfig.horizontal(17)),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  blurRadius: 2,
                                  color: AppColors.greyDisabled,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2))
                            ]),
                      ),
                      // homeController.isLoading.isTrue
                      //             ? const HomeShimmer()
                      ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        children: <ResponsiveRowColumnItem>[
                          const ResponsiveRowColumnItem(
                              child: CustomAppBarHome()),
                          ResponsiveRowColumnItem(
                              child: PromoWidget(
                            carouselController: carouselController,
                          )),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                          ResponsiveRowColumnItem(
                            child: Padding(
                              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (_, HomeState state) {
                                  return InterTextView(
                                      value: state.gridMenuTitle,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      size: SizeConfig.safeBlockHorizontal * 4);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                ])
          ]),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (_, HomeState state) {
            return SliverGrid.builder(
              itemCount: state.beresinMenuList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) => BeresinMenu(
                onRoute: () {},
                model: state.beresinMenuList[index],
              ),
            );
          },
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.horizontal(2),
                  right: SizeConfig.horizontal(2),
                  left: SizeConfig.horizontal(2)),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (_, HomeState state) {
                  return ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: state.aboutAutomotiveTitle,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                            size: SizeConfig.safeBlockHorizontal * 4),
                      ),
                      ResponsiveRowColumnItem(
                        child: CustomRippleButton(
                          onTap: () => router.go('/lihatsemua',
                              extra: state.aboutAutomotiveList),
                          child: InterTextView(
                              value: 'Lihat semua',
                              color: AppColors.blackBackground,
                              fontWeight: FontWeight.w500,
                              size: SizeConfig.safeBlockHorizontal * 3.5),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ]),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
              top: SizeConfig.horizontal(1), bottom: SizeConfig.horizontal(15)),
          sliver: const AutomotiveNews(),
        ),
      ]),
    );
  }
}

class PromoSlideView extends StatelessWidget {
  const PromoSlideView({
    super.key,
    required this.carouselController,
  });

  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, HomeState state) {
        return CarouselSlider.builder(
            carouselController: carouselController,
            options: CarouselOptions(
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                autoPlay: true,
                aspectRatio: 9 / 4,
                enlargeCenterPage: true,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  context
                      .read<HomeBloc>()
                      .add(OnSlideChange(activeIndex: index));
                }),
            itemCount: state.promoImage.length,
            itemBuilder: (BuildContext context, int index, int realIndex) =>
                Center(
                    child: CustomRippleButton(
                        radius: 0,
                        onTap: () {},
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius
                                    .circular(SizeConfig.horizontal(1))),
                            child: state
                                    .promoImage.isEmpty
                                ? const CircularProgressIndicator()
                                : CachedNetworkImage(
                                    maxWidthDiskCache: 350,
                                    maxHeightDiskCache: 250,
                                    imageUrl: state.promoImage[index],
                                    fit: BoxFit.fill,
                                    width: SizeConfig.horizontal(100),
                                    height: SizeConfig.horizontal(100))))));
      },
    );
  }
}
