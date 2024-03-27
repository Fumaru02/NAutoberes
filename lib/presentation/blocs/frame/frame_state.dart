part of 'frame_bloc.dart';

enum FrameStatus { initial, loading, loaded }

class FrameState extends Equatable {
  const FrameState({
    required this.isOutsideFrame,
    required this.currentRoute,
    required this.frameStatus,
    required this.defaultIndex,
    required this.widgetViewList,
    required this.identifierList,
  });

  factory FrameState.initial() => const FrameState(
      frameStatus: FrameStatus.initial,
      defaultIndex: 0,
      currentRoute: '',
      isOutsideFrame: false,
      identifierList: <OnTapIdentifier>[],
      widgetViewList: <Widget>[]);
  final bool isOutsideFrame;
  final String currentRoute;
  final FrameStatus frameStatus;
  final int defaultIndex;
  final List<Widget> widgetViewList;
  final List<OnTapIdentifier> identifierList;
  @override
  List<Object> get props {
    return <Object>[
      isOutsideFrame,
      currentRoute,
      frameStatus,
      defaultIndex,
      widgetViewList,
      identifierList,
    ];
  }

  FrameState copyWith({
    bool? isOutsideFrame,
    String? currentRoute,
    FrameStatus? frameStatus,
    int? defaultIndex,
    List<Widget>? widgetViewList,
    List<OnTapIdentifier>? identifierList,
  }) {
    return FrameState(
      isOutsideFrame: isOutsideFrame ?? this.isOutsideFrame,
      currentRoute: currentRoute ?? this.currentRoute,
      frameStatus: frameStatus ?? this.frameStatus,
      defaultIndex: defaultIndex ?? this.defaultIndex,
      widgetViewList: widgetViewList ?? this.widgetViewList,
      identifierList: identifierList ?? this.identifierList,
    );
  }

  @override
  String toString() {
    return 'FrameState(isOutsideFrame: $isOutsideFrame, currentRoute: $currentRoute, frameStatus: $frameStatus, defaultIndex: $defaultIndex, widgetViewList: $widgetViewList, identifierList: $identifierList)';
  }
}
