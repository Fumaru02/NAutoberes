import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/home/home_cubit.dart';

class ScrollToHideWidget extends StatelessWidget {
  const ScrollToHideWidget({
    super.key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
  });

  final Widget child;
  final ScrollController controller;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_final_locals
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (_, HomeCubitState state) {
        return AnimatedContainer(
          height: state.isVisible == false ? kBottomNavigationBarHeight : 0,
          duration: duration,
          child: child,
        );
      },
    );
  }
}
