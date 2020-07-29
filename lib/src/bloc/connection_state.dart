import "package:equatable/equatable.dart";
import "package:meta/meta.dart";

@immutable
abstract class ConnectionState extends Equatable {
  ConnectionState();
}

class ConnectionDisconected extends ConnectionState {
  @override
  List<Object> get props => props;

  @override
  String toString() => "ConnectionDisconected";
}

class ConnectionConnected extends ConnectionState {
  @override
  List<Object> get props => props;

  @override
  String toString() => "ConnectionConected";
}

class ConnectionConnecting extends ConnectionState {
  @override
  List<Object> get props => props;

  @override
  String toString() => "ConnectionConecting";
}

class ConnectionDisconnecting extends ConnectionState {
  @override
  List<Object> get props => props;

  @override
  String toString() => "ConnectionDisconecting";
}
