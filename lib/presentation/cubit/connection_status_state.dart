part of 'connection_status_cubit.dart';

class ConnectionStatusState extends Equatable {
  const ConnectionStatusState(
    this.connectionType,
  );

  factory ConnectionStatusState.inital() =>
      const ConnectionStatusState(0);

  final int connectionType;

  @override
  List<Object> get props => <Object>[];

  ConnectionStatusState copyWith({
    int? connectionType,
  }) {
    return ConnectionStatusState(
      connectionType ?? this.connectionType,
    );
  }

  @override
  String toString() => 'ConnectionStatusState(connectionType: $connectionType)';
}
