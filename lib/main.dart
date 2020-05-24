import 'package:flutter/material.dart';

import 'vehicleController.dart';
import 'appConfigure.dart';
import 'behaviorTricks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title = 'RPi-Car remote control';
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
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: title),
        '/vehicleControls': (context) => VehicleControllerSLess(title: title),
        '/appConfig': (context) => AppConfiguration(title: title),
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
  @override
  initState() {
    super.initState();
    landscapeModeOnly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controles del vehiculo'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Text('¡hola mundo!'),
            RaisedButton(
              child: Text('Volver'),
              onPressed: () {
                Navigator.pushNamed(context, '/vehicleControls');
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    enableRotation();
  }
}
