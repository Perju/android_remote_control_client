import "dart:async";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:meta/meta.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;
import "connection_event.dart";
import "connection_state.dart";

class ConnectionBloc extends Bloc<ConnectionEvent, MyConnectionState> {
  final IO.Socket socket;
  ConnectionBloc({@required this.socket})
      : super(ConnectionDisconected({
          "rightSign": false,
          "hazard": false,
          "light": false,
          "leftSign": false,
          "horn": false,
          "config": false
        }));

  @override
  Stream<MyConnectionState> mapEventToState(
    ConnectionEvent event,
  ) async* {
    if (event is Connect) {
      yield* _connect();
    } else if (event is Disconnect) {
      yield* _disconnect();
    } else if (event is SendSignal) {
      yield* _sendSignal(event);
    } else if (event is ReciveData) {
      yield* _reciveData(event);
    } else if (event is SendSteer) {
      _sendSteer(event);
    }
  }

  Stream<MyConnectionState> _connect() async* {
    socket.connect();
    socket.on("signal", (data) {
      add(ReciveData(data));
    });
    yield ConnectionConnected(state.signals);
  }

  Stream<MyConnectionState> _disconnect() async* {
    socket.disconnect();
    yield ConnectionDisconected(state.signals);
  }

  Stream<MyConnectionState> _sendSignal(SendSignal event) async* {
    socket.emit("signal", event.data);
    yield ConnectionConnected(state.signals);
  }
  void _sendSteer(SendSteer event) {
    socket.emit("pruebas", event.data);
  }

  Stream<MyConnectionState> _reciveData(ReciveData event) async* {
    var newSignals = Map.from(state.signals);
    newSignals[event.data["type"]] = event.data["state"];
    yield ConnectionConnected(newSignals);
  }
}
