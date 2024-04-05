part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.aboutAutomotiveTitle,
    required this.promoTitle,
    required this.gridMenuTitle,
    required this.currentDot,
    required this.beresinMenuList,
    required this.aboutAutomotiveList,
    required this.promoImage,
  });

  factory HomeState.initial() => const HomeState(
        promoTitle: '',
        promoImage: <String>[],
        aboutAutomotiveTitle: '',
        gridMenuTitle: '',
        currentDot: 0,
        beresinMenuList: <BeresinMenuModel>[],
        aboutAutomotiveList: <AboutAutomotiveModel>[],
      );
  final String aboutAutomotiveTitle;
  final String promoTitle;
  final String gridMenuTitle;
  final int currentDot;
  final List<BeresinMenuModel> beresinMenuList;
  final List<AboutAutomotiveModel> aboutAutomotiveList;
  final List<String> promoImage;
  @override
  List<Object> get props {
    return <Object>[
      aboutAutomotiveTitle,
      promoTitle,
      gridMenuTitle,
      currentDot,
      beresinMenuList,
      aboutAutomotiveList,
      promoImage,
    ];
  }

  HomeState copyWith({
    String? aboutAutomotiveTitle,
    String? promoTitle,
    String? gridMenuTitle,
    int? currentDot,
    List<BeresinMenuModel>? beresinMenuList,
    List<AboutAutomotiveModel>? aboutAutomotiveList,
    List<String>? promoImage,
  }) {
    return HomeState(
      aboutAutomotiveTitle: aboutAutomotiveTitle ?? this.aboutAutomotiveTitle,
      promoTitle: promoTitle ?? this.promoTitle,
      gridMenuTitle: gridMenuTitle ?? this.gridMenuTitle,
      currentDot: currentDot ?? this.currentDot,
      beresinMenuList: beresinMenuList ?? this.beresinMenuList,
      aboutAutomotiveList: aboutAutomotiveList ?? this.aboutAutomotiveList,
      promoImage: promoImage ?? this.promoImage,
    );
  }

  @override
  String toString() {
    return 'HomeState(aboutAutomotiveTitle: $aboutAutomotiveTitle, promoTitle: $promoTitle, gridMenuTitle: $gridMenuTitle, currentDot: $currentDot, beresinMenuList: $beresinMenuList, aboutAutomotiveList: $aboutAutomotiveList, promoImage: $promoImage)';
  }
}
