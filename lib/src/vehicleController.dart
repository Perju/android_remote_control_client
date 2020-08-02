import 'package:control_pad/models/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/pad_button_item.dart';
import "./bloc/connection_bloc.dart";
import "./bloc/connection_event.dart";

class VehicleController extends StatelessWidget {
//  _VehicleControllerState createState() => _VehicleControllerState();
  VehicleController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final connectionBloc = BlocProvider.of<ConnectionBloc>(context);
    final Widget padButtons = PadButtonsView(
      padButtonPressedCallback: (i, gesture) {
        var data;
        switch (i) {
          case 0:
            data = {"type": "rightSign", "state": "!widget.rightSign"};
            break;
          case 1:
            data = {"type": "emergencias", "state": "!widget.hazard"};
            break;
          case 2:
            data = {"type": "light", "state": "!widget.light"};
            break;
          case 3:
            data = {"type": "leftSign", "state": "!widget.leftSign"};
            break;
          case 4:
            final state = gesture == Gestures.LONGPRESSSTART;
            data = {"type": "horn", "state": state};
            break;
          case 5:
            data = {"type": "config", "mis": "hm"};
            break;
        }
        connectionBloc.add(SendData(data));
      },
      buttons: _createButtons(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, '/appConfig');
          },
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            JoystickView(
              interval: Duration(milliseconds: 1000),
              showArrows: true,
              size: 224,
              onDirectionChanged: (grados, distanciaNormalizada) {
                print('Grados: ' + grados.toString());
                print('distancia: ' + distanciaNormalizada.toString());
              },
            ),
            SizedBox(
              width: 120.0,
            ),
            padButtons,
          ],
        ),
      ),
    );
  }
}

List<PadButtonItem> _createButtons() {
  final List<PadButtonItem> buttons = [
    PadButtonItem(
      index: 0,
      buttonIcon: Icon(Icons.fast_forward),
      supportedGestures: [Gestures.TAP],
    ),
    PadButtonItem(
      index: 1,
      buttonIcon: Icon(Icons.change_history),
      supportedGestures: [Gestures.TAP],
    ),
    PadButtonItem(
      index: 2,
      buttonIcon: Icon(Icons.lightbulb_outline),
      supportedGestures: [Gestures.TAP],
    ),
    PadButtonItem(
      index: 3,
      buttonIcon: Icon(Icons.fast_rewind),
      supportedGestures: [Gestures.TAP],
    ),
    PadButtonItem(
      index: 4,
      buttonIcon: Icon(Icons.volume_up),
      supportedGestures: [Gestures.LONGPRESSSTART, Gestures.LONGPRESSUP],
    ),
    PadButtonItem(
      index: 5,
      buttonIcon: Icon(Icons.settings),
      supportedGestures: [Gestures.TAP],
    ),
  ];

  return buttons;
}
