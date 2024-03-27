part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetDataHome extends HomeEvent {}

class GetPromo extends HomeEvent {}

class OnSlideChange extends HomeEvent {
  const OnSlideChange({
    required this.activeIndex,
  });
  final int activeIndex;
}
