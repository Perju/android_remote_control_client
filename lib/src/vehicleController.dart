import 'package:control_pad/models/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/pad_button_item.dart';
import "./bloc/connection_bloc.dart";
import "./bloc/connection_event.dart";

class VehicleControllerSLess extends StatelessWidget {
//  _VehicleControllerState createState() => _VehicleControllerState();
  VehicleControllerSLess({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final connectionBloc = BlocProvider.of<ConnectionBloc>(context);
    final Widget padButtons = PadButtonsView(
      padButtonPressedCallback: (i, gesture) {
        var data;
        switch (i) {
          case 0:
            data = {"accion": "intermitentes", "lado": "derecho"};
            break;
          case 1:
            data = {"accion": "emergencias", "estado": "encender"};
            break;
          case 2:
            data = {"accion": "luces", "estado": "on"};
            break;
          case 3:
            data = {"accion": "intermitentes", "lado": "izquierdo"};
            break;
          case 4:
            data = {"accion": "claxon", "estado": "on"};
            break;
          case 5:
            data = {"accion": "config", "mis": "hm"};
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
  final List<PadButtonItem> buttons = [];
  final List<IconData> icons = [
    Icons.fast_forward,
    Icons.change_history,
    Icons.lightbulb_outline,
    Icons.fast_rewind,
    Icons.volume_up,
    Icons.settings,
  ];

  icons.forEach((iconData) {
    final i = icons.indexOf(iconData);
    final icon = Icon(iconData);
    buttons.add(PadButtonItem(
        index: i, buttonIcon: icon, supportedGestures: Gestures.values));
  });
  PadButtonItem boton;
  return buttons;
}
