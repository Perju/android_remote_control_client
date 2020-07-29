import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/gestures.dart';
import 'package:control_pad/models/pad_button_item.dart';

class VehicleControllerSLess extends StatelessWidget {
//  _VehicleControllerState createState() => _VehicleControllerState();
  VehicleControllerSLess({Key key, this.title}) : super(key: key);

  final String title;

  final Widget padButtons = PadButtonsView(
    padButtonPressedCallback: (buttonNumber, gesture) {
      print('Botón: ' + buttonNumber.toString());
      print('Gesto: ' + gesture.toString());
    },
    buttons: [
      PadButtonItem(
        index: 1,
        buttonText: '1',
        supportedGestures: [Gestures.TAP],
      ),
      PadButtonItem(
        index: 2,
        buttonText: '2',
      ),
      PadButtonItem(
        index: 3,
        buttonText: 'E',
      ),
      PadButtonItem(
        index: 4,
        buttonText: '4',
      ),
      PadButtonItem(
        index: 5,
        buttonText: '5',
      ),
      PadButtonItem(
        index: 6,
        buttonText: '6',
      ),
    ],
  );

  final List<PadButtonItem> buttons = [];

  final PadButtonItem button1 = PadButtonItem(index: 1, buttonText: '1');
  final PadButtonItem button2 = PadButtonItem(index: 1, buttonText: '2');
  final PadButtonItem button3 = PadButtonItem(index: 1, buttonText: '3');
  final PadButtonItem button4 = PadButtonItem(index: 1, buttonText: '4');

  @override
  Widget build(BuildContext context) {
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
