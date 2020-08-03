import "package:equatable/equatable.dart";
import "package:meta/meta.dart";

@immutable
abstract class MyConnectionState extends Equatable {
  final Map signals;

  MyConnectionState(this.signals);

  @override
  List<Object> get props => [signals];
}

class ConnectionDisconected extends MyConnectionState {
  ConnectionDisconected(signals):super(signals);

  @override
  String toString() => "ConnectionDisconected";
}

class ConnectionConnected extends MyConnectionState {
  ConnectionConnected(signals):super(signals);

  @override
  String toString() => "ConnectionConected";
}

class ConnectionConnecting extends MyConnectionState {
  ConnectionConnecting(signals):super(signals);

  @override
  String toString() => "ConnectionConecting";
}

class ConnectionDisconnecting extends MyConnectionState {
  ConnectionDisconnecting(signals):super(signals);

  @override
  String toString() => "ConnectionDisconecting";
}
