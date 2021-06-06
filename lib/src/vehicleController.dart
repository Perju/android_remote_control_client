import 'package:control_pad/models/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/pad_button_item.dart';
import "./bloc/bloc.dart";

class Joystick extends StatelessWidget {
  Joystick(this.side);
  final side;
  Widget build(BuildContext context) {
    return JoystickView(
        interval: Duration(milliseconds: 250),
        showArrows: true,
        size: 224,
        onDirectionChanged: (degree, factor) {
          context.read<ConnectionBloc>().add(SendSteer({
                "motor": side,
                "degree": degree,
                "factor": factor,
              }));
        });
  }
}

class VehicleController extends StatelessWidget {
  VehicleController({required this.title});

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
            context.read<ConnectionBloc>().add(SendSignal(signals[i]));
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
                Joystick("left"),
                SizedBox(width: 12.0),
                padButtons,
                SizedBox(width: 12.0),
                Joystick("right"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPanel extends StatelessWidget {
  Widget infoIcon(signal, icon) {
    return DecoratedBox(
        decoration: BoxDecoration(
          color: signal ? Colors.green : Colors.grey,
        ),
        child: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, MyConnectionState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            infoIcon(state.signals["hazard"] ?? false, Icons.change_history),
            infoIcon(state.signals["light"] ?? false, Icons.lightbulb_outline),
            infoIcon(state.signals["leftSign"] ?? false, Icons.fast_rewind),
            infoIcon(state.signals["horn"] ?? false, Icons.volume_up),
            infoIcon(state.signals["rightSign"] ?? false, Icons.fast_forward),
          ],
        );
      },
    );
  }
}

List<PadButtonItem> _createButtons() {
  final List<IconData> iButons = [
    Icons.fast_forward,
    Icons.change_history,
    Icons.lightbulb_outline,
    Icons.fast_rewind,
    Icons.volume_up,
    Icons.settings,
  ];

  List<PadButtonItem> buttons = [];
  iButons.forEach((e) => {
        buttons.add(PadButtonItem(
            index: iButons.indexOf(e),
            buttonIcon: Icon(e),
            supportedGestures: e == Icons.volume_up
                ? [Gestures.TAPDOWN, Gestures.TAPUP, Gestures.LONGPRESSUP]
                : [Gestures.TAP]))
      });

  return buttons;
}
