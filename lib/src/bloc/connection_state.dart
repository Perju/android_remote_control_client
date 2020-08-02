import "package:equatable/equatable.dart";
import "package:meta/meta.dart";

@immutable
abstract class MyConnectionState extends Equatable {
  MyConnectionState();
}

class ConnectionDisconected extends MyConnectionState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "ConnectionDisconected";
}

class ConnectionConnected extends MyConnectionState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "ConnectionConected";
}

class ConnectionConnecting extends MyConnectionState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "ConnectionConecting";
}

class ConnectionDisconnecting extends MyConnectionState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "ConnectionDisconecting";
}
