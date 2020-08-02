import "dart:async";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:meta/meta.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;
import "connection_event.dart";
import "connection_state.dart";

class ConnectionBloc extends Bloc<ConnectionEvent, MyConnectionState> {
  final IO.Socket socket;
  ConnectionBloc({@required this.socket}) : super(ConnectionDisconected());

  @override
  Stream<MyConnectionState> mapEventToState(
    ConnectionEvent event,
  ) async* {
    if (event is Connect) {
      yield* _connect();
    } else if (event is Disconnect) {
      yield* _disconnect();
    } else if (event is SendData) {
      yield* _sendData(event);
    }
  }

  Stream<MyConnectionState> _connect() async* {
    socket.connect();
    yield ConnectionConnected();
  }

  Stream<MyConnectionState> _disconnect() async* {
    socket.disconnect();
    yield ConnectionDisconected();
  }

  Stream<MyConnectionState> _sendData(SendData event) async* {
    socket.emit("pruebas", event.data);
    yield ConnectionConnected();
  }
}
