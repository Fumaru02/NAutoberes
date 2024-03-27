import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../blocs/frame/frame_bloc.dart';
import '../../widgets/frame/frame_bottom_nav_bar.dart';
import '../../widgets/user/user_info.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
//this class for setting up bottomnavbar
  @override
  void initState() {
    super.initState();
    context.read<FrameBloc>().add(OnInitBottomNavBar());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FrameBloc, FrameState>(
      builder: (_, FrameState state) => FrameBottomNav(
        isUseLeading: _useBackButton(state),
        isImplyLeading: false,
        elevation: 0,
        action: _customAction(state),
        heightBar: _whenUseHeightBar(state),
        isCenter: _isCenterTitle(state),
        titleScreen: _useTitleAppBar(state),
        color: AppColors.blackBackground,
      ),
    );
  }

  Widget _customAction(FrameState state) {
    if (state.defaultIndex == 1) {
      return const Padding(
        padding: EdgeInsets.all(2),
        child: UserPicture(
          width: 13,
          height: 12,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  bool _isCenterTitle(FrameState state) {
    if (state.defaultIndex == 2 ||
        state.defaultIndex == 3 ||
        state.defaultIndex == 4) {
      return true;
    } else {
      return false;
    }
  }

  double _whenUseHeightBar(FrameState state) {
    if (state.defaultIndex == 1 || state.defaultIndex == 3) {
      return SizeConfig.horizontal(14);
    } else {
      return 0;
    }
  }

  String _useTitleAppBar(FrameState state) {
    if (state.defaultIndex == 1) {
      return 'Chat Room';
    } else if (state.defaultIndex == 3) {
      return 'Workshop';
    } else {
      return '';
    }
  }

  bool _useBackButton(FrameState state) {
    if (state.defaultIndex == 1) {
      return true;
    } else {
      return false;
    }
  }
}
