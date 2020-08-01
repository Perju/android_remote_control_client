import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'src/bloc/connection_bloc.dart';
import 'src/vehicleController.dart';
import 'src/appConfigure.dart';
import 'src/behaviorTricks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    const title = 'RPi-Car remote control';
    final ConnectionBloc connectionBloc = ConnectionBloc(
        socket: IO.io("", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket']
    }));
    return BlocProvider<ConnectionBloc>(
      create: (BuildContext context) => connectionBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.white,
            ),
            headline4: TextStyle(
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
      ),
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
