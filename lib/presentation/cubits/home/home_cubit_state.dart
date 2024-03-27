part of 'home_cubit.dart';

class HomeCubitState extends Equatable {
  const HomeCubitState({
    required this.greetings,
    required this.isVisible,
  });

  factory HomeCubitState.initial() =>
      const HomeCubitState(greetings: '', isVisible: false);
  final String greetings;
  final bool isVisible;
  @override
  List<Object> get props => <Object>[greetings, isVisible];

  HomeCubitState copyWith({
    String? greetings,
    bool? isVisible,
  }) {
    return HomeCubitState(
      greetings: greetings ?? this.greetings,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  String toString() =>
      'HomeCubitState(greetings: $greetings, isVisible: $isVisible)';
}
