part of 'frame_bloc.dart';

class FrameState extends Equatable {
  const FrameState({
    required this.isOutsideFrame,
    required this.currentRoute,
    required this.frameStatus,
    required this.defaultIndex,
    required this.widgetViewList,
    required this.identifierList,
  });

  factory FrameState.initial() => FrameState(
          frameStatus: FrameStatus.initial,
          defaultIndex: 0,
          currentRoute: '',
          isOutsideFrame: false,
          identifierList: <OnTapIdentifier>[
            OnTapIdentifier(name: 'Home', index: 0, isOnTapped: true),
            OnTapIdentifier(name: 'Chat', index: 1, isOnTapped: false),
            OnTapIdentifier(name: 'Services', index: 2, isOnTapped: false),
            OnTapIdentifier(name: 'Workshop', index: 3, isOnTapped: false),
            OnTapIdentifier(name: 'Akun', index: 4, isOnTapped: false),
          ],
          widgetViewList: const <Widget>[
            HomeView(),
            ChatView(),
            HomeServicesView(),
            WorkshopView(),
            AkunView(),
          ]);
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
