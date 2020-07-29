import "dart:async";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";
import "connection_event.dart";
import "connection_state.dart";
import "../models/connection.dart";

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final Connection connection;
  ConnectionBloc({@required this.connection}) : super(ConnectionDisconected());

  @override
  Stream<ConnectionState> mapEventToState(
    ConnectionEvent event,
  ) async* {
    if (event is Connect) {
      yield* _connect();
    } else if (event is Disconnect) {
      yield* _disconnect();
    } else if (event is SendData) {
      yield* _sendData();
    }
  }

  Stream<void> _connect() async* {}
  Stream<void> _disconnect() async* {}
  Stream<void> _sendData() async* {}
}
