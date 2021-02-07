import 'package:control_pad/models/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/pad_button_item.dart';
import "./bloc/bloc.dart";

class VehicleController extends StatelessWidget {
  VehicleController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    List<dynamic> signals = [
      {"type": "rightSign", "state": true},
      {"type": "hazard", "state": true},
      {"type": "light", "state": true},
      {"type": "leftSign", "state": true},
      {"type": "horn", "state": true},
      {"type": "config", "mis": "hm", "state": true}
    ];
    final Widget padButtons = BlocBuilder<ConnectionBloc, MyConnectionState>(
      builder: (context, state) {
        return PadButtonsView(
          padButtonPressedCallback: (i, gesture) {
            if (i == 4) {
              signals[i]["state"] = gesture == Gestures.TAPDOWN;
            } else {
              signals[i]["state"] = !state.signals[signals[i]["type"]];
            }
            context.bloc<ConnectionBloc>().add(SendSignal(signals[i]));
          },
          buttons: _createButtons(),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/appConfig', ModalRoute.withName('/'));
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InfoPanel(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                JoystickView(
                  interval: Duration(milliseconds: 1000),
                  showArrows: true,
                  size: 224,
                  onDirectionChanged: (degree, factor) {
                    print('Grados: ' + degree.toString());
                    print('distancia: ' + factor.toString());
                    context.bloc<ConnectionBloc>().add(SendSteer({"degree":degree,"factor":factor,}));
                  },
                ),
                SizedBox(
                  width: 120.0,
                ),
                padButtons,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, MyConnectionState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DecoratedBox(
                decoration: BoxDecoration(
                    color:
                        state.signals["hazard"] ? Colors.green : Colors.grey),
                child: Icon(Icons.change_history)),
            DecoratedBox(
                decoration: BoxDecoration(
                    color: state.signals["light"] ? Colors.green : Colors.grey),
                child: Icon(Icons.lightbulb_outline)),
            DecoratedBox(
                decoration: BoxDecoration(
                    color: state.signals["leftSign"]
                        ? Colors.green
                        : Colors.grey),
                child: Icon(Icons.fast_rewind)),
            DecoratedBox(
                decoration: BoxDecoration(
                    color: state.signals["horn"] ? Colors.green : Colors.grey),
                child: Icon(Icons.volume_up)),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      state.signals["rightSign"] ? Colors.green : Colors.grey),
              child: Icon(Icons.fast_forward),
            ),
          ],
        );
      },
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
      supportedGestures: [
        Gestures.TAPDOWN,
        Gestures.TAPUP,
        Gestures.LONGPRESSUP
      ],
    ),
    PadButtonItem(
      index: 5,
      buttonIcon: Icon(Icons.settings),
      supportedGestures: [Gestures.TAP],
    ),
  ];

  return buttons;
}
