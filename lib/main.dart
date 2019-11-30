import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/gestures.dart';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:flutter/material.dart';
import 'vehicleController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        textTheme: TextTheme(
            body1: TextStyle(
              color: Colors.white,
            ),
            display1: TextStyle(
              color: Colors.white,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/vehicleControls': (context) => VehicleController(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PadButtonItem> buttons = [];

  PadButtonItem button1 = PadButtonItem(index: 1, buttonText: '1');
  PadButtonItem button2 = PadButtonItem(index: 1, buttonText: '2');
  PadButtonItem button3 = PadButtonItem(index: 1, buttonText: '3');
  PadButtonItem button4 = PadButtonItem(index: 1, buttonText: '4');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.drive_eta),
          onPressed: () {
            Navigator.pushNamed(context, '/vehicleControls');
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
            SizedBox(
              width: 120.0,
            ),
            PadButtonsView(
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
                ),PadButtonItem(
                  index: 6,
                  buttonText: '6',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
