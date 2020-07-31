import "package:equatable/equatable.dart";
import "package:meta/meta.dart";

@immutable
abstract class ConnectionEvent extends Equatable {
  ConnectionEvent();
}

class Connect extends ConnectionEvent {
  @override
  List<Object> get props => props;
}

class Disconnect extends ConnectionEvent {
  @override
  List<Object> get props => props;
}

class SendData extends ConnectionEvent {
  SendData(this.data);
  final dynamic data;
  @override
  List<Object> get props => props;
}
