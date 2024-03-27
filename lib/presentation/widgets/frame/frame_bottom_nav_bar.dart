import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/frame/frame_bloc.dart';
import '../../pages/home/home_view.dart';
import '../custom/custom_scroll_to_hide_widget.dart';
import '../text/inter_text_view.dart';
import '../user/user_info.dart';
import 'frame_appbar.dart';

class FrameBottomNav extends FrameAppBar {
  const FrameBottomNav({
    super.titleScreen,
    super.heightBar,
    super.color,
    super.isCenter,
    super.elevation,
    super.isUseLeading,
    super.onBack,
    super.customLeading,
    super.action,
    super.isImplyLeading,
    super.customTitle,
    // status bar
    super.statusBarColor,
    super.statusBarIconBrightness,
    super.statusBarBrightness,
    // scaffold
    this.colorScaffold,
    super.key,
  });

  final Color? colorScaffold;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FrameBloc, FrameState>(
      builder: (_, FrameState state) {
        return DefaultTabController(
            length: state.widgetViewList.length,
            child: Scaffold(
                backgroundColor: colorScaffold,
                extendBody: true,
                appBar: FrameAppBar(
                  titleScreen: titleScreen,
                  heightBar: heightBar,
                  color: color,
                  elevation: elevation,
                  isCenter: isCenter,
                  isUseLeading: isUseLeading,
                  onBack: onBack,
                  customLeading: customLeading,
                  action: action,
                  isImplyLeading: isImplyLeading,
                  customTitle: customTitle,
                  statusBarColor: statusBarColor,
                  statusBarIconBrightness: statusBarIconBrightness,
                  statusBarBrightness: statusBarBrightness,
                ),
                body: IndexedStack(
                  index: state.defaultIndex,
                  children: state.widgetViewList,
                ),
                floatingActionButtonLocation: state.defaultIndex == 0
                    ? FloatingActionButtonLocation.miniEndFloat
                    : null,
                floatingActionButton: state.defaultIndex == 0
                    ? _CenterFloatingButton(
                        state: state,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) => Container(),
                          );
                        },
                      )
                    : null,
                bottomNavigationBar: state.defaultIndex != 1
                    ? _bottomAppBar(context: context, state: state)
                    : null));
      },
    );
  }

  BottomAppBar _bottomAppBar(
      {required BuildContext context, required FrameState state}) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: ScrollToHideWidget(
        controller: scrollController,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            onTap: (int index) {
              return context
                  .read<FrameBloc>()
                  .add(OnTapBottomNav(index: index));
            },
            type: BottomNavigationBarType.fixed,
            elevation: 8.0,
            backgroundColor: const Color.fromARGB(255, 247, 247, 247),
            selectedLabelStyle: const TextStyle(fontSize: 0),
            unselectedLabelStyle: const TextStyle(fontSize: 0),
            iconSize: 0,
            items: menuList(state),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> menuList(FrameState state) {
    return <BottomNavigationBarItem>[
      _bottomNavigationBarItemDefault(
        state: state,
        icon: Icons.home,
        label: 'Home',
        index: 0,
      ),
      _chatBottomNavBar(
        icon: Icons.chat,
        label: 'Chat',
        index: 1,
        state: state,
      ),
      _bottomNavigationBarItemDefault(
        state: state,
        icon: Icons.home_repair_service,
        label: 'Home Service',
        index: 2,
      ),
      _bottomNavigationBarItemDefault(
        state: state,
        icon: Icons.store_mall_directory_sharp,
        label: 'Workshop',
        index: 3,
      ),
      _akunBottomNavBar(
        state: state,
        icon: Icons.person_2_outlined,
        label: 'Akun',
        index: 4,
      ),
    ];
  }

  BottomNavigationBarItem _akunBottomNavBar({
    required IconData icon,
    required String label,
    required int index,
    required FrameState state,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _AkunWrapper(
        state: state,
        icon: icon,
        label: label,
        index: index,
        widthIcon: widthIcon,
        heightIcon: heightIcon,
      ),
      label: '',
    );
  }

  BottomNavigationBarItem _chatBottomNavBar({
    required IconData icon,
    required String label,
    required int index,
    required FrameState state,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _ChatMenuItemWrapper(
        frameState: state,
        icon: icon,
        label: label,
        index: index,
        widthIcon: widthIcon,
        heightIcon: heightIcon,
      ),
      label: '',
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItemDefault({
    required IconData icon,
    required String label,
    required int index,
    required FrameState state,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _MenuItemWrapper(
        state: state,
        icon: icon,
        label: label,
        index: index,
        widthIcon: widthIcon,
        heightIcon: heightIcon,
      ),
      label: '',
    );
  }
}

class _CenterFloatingButton extends StatelessWidget {
  const _CenterFloatingButton({
    required this.onTap,
    required this.state,
  });

  final Function() onTap;
  final FrameState state;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor:
          state.defaultIndex == 5 ? AppColors.grey : AppColors.redAlert,
      elevation: 0,
      onPressed: onTap,
      child: ResponsiveRowColumnItem(
          child: Icon(Icons.phone,
              color: AppColors.white, size: SizeConfig.horizontal(8))),
    );
  }
}

class _AkunWrapper extends StatelessWidget {
  const _AkunWrapper({
    required this.icon,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.state,
  });

  final IconData icon;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameState state;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: state.identifierList[index].isOnTapped == true
                ? Icon(icon,
                    size: heightIcon ?? SizeConfig.safeBlockHorizontal * 8,
                    color: AppColors.blackBackground)
                : const UserPicture(
                    width: 7,
                    height: 7,
                  )),
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: label,
                color: state.identifierList[index].isOnTapped == true
                    ? AppColors.blackBackground
                    : AppColors.greyDisabled,
                size: widthIcon == null && heightIcon == null
                    ? SizeConfig.safeBlockHorizontal * 2.7
                    : SizeConfig.safeBlockHorizontal * 2.8,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _MenuItemWrapper extends StatelessWidget {
  const _MenuItemWrapper({
    required this.icon,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.state,
  });

  final IconData icon;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameState state;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
          child: Icon(
            icon,
            size: heightIcon ?? SizeConfig.safeBlockHorizontal * 8,
            color: state.identifierList[index].isOnTapped == true
                ? AppColors.blackBackground
                : AppColors.greyDisabled,
          ),
        ),
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: label,
                color: state.identifierList[index].isOnTapped == true
                    ? AppColors.blackBackground
                    : AppColors.greyDisabled,
                size: widthIcon == null && heightIcon == null
                    ? SizeConfig.safeBlockHorizontal * 2.7
                    : SizeConfig.safeBlockHorizontal * 2.8,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _ChatMenuItemWrapper extends StatelessWidget {
  const _ChatMenuItemWrapper({
    required this.icon,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.frameState,
  });

  final IconData icon;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameState frameState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (_, ChatState state) {
      return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: Stack(
            children: <Widget>[
              Icon(icon,
                  size: heightIcon ?? SizeConfig.safeBlockHorizontal * 8,
                  color: AppColors.greyDisabled),
              // ignore: prefer_if_elements_to_conditional_expressions
              state.totalUnread == 0
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.horizontal(1),
                          left: SizeConfig.horizontal(3)),
                      child: CircleAvatar(
                        radius: SizeConfig.horizontal(2),
                        backgroundColor: AppColors.redAlert,
                        child: InterTextView(
                          value: '${state.totalUnread}',
                          size: SizeConfig.safeBlockHorizontal * 3,
                        ),
                      ),
                    )
            ],
          )),
          ResponsiveRowColumnItem(
              child: InterTextView(
                  value: label,
                  color: frameState.identifierList[index].isOnTapped == true
                      ? AppColors.blackBackground
                      : AppColors.greyDisabled,
                  size: widthIcon == null && heightIcon == null
                      ? SizeConfig.safeBlockHorizontal * 2.7
                      : SizeConfig.safeBlockHorizontal * 2.8,
                  fontWeight: FontWeight.w500)),
        ],
      );
    });
  }
}
