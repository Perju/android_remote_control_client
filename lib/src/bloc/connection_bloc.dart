import "dart:async";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;
import "connection_event.dart";
import "connection_state.dart";

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final IO.Socket socket;
  ConnectionBloc({@required this.socket}) : super(ConnectionDisconected());

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

  Stream<ConnectionState> _connect() async* {
    socket.connect();
    yield ConnectionConnected();
  }

  Stream<void> _disconnect() async* {}
  Stream<void> _sendData() async* {}
}
