import "package:equatable/equatable.dart";
import "package:meta/meta.dart";

@immutable
abstract class ConnectionEvent extends Equatable {
  ConnectionEvent();
  @override
  List<Object> get props => [];
}

class Connect extends ConnectionEvent {}

class Disconnect extends ConnectionEvent {}

class SendSignal extends ConnectionEvent {
  final dynamic data;
  SendSignal(this.data);
}

class SendSteer extends ConnectionEvent {
  final dynamic data;
  SendSteer(this.data);
}

class ReciveData extends ConnectionEvent {
  ReciveData(this.data);
  final Map data;
}
