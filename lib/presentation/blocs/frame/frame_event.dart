part of 'frame_bloc.dart';

sealed class FrameEvent extends Equatable {
  const FrameEvent();

  @override
  List<Object> get props => <Object>[];
}

class OnTapBottomNav extends FrameEvent {
  const OnTapBottomNav({required this.index});

  final int index;
}

class OnInitBottomNavBar extends FrameEvent {}

class OnCheckUserNavigate extends FrameEvent {
  const OnCheckUserNavigate({
    required this.status,
    required this.route,
  });

  final bool status;
  final String route;
}
