// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'src/bloc/connection_bloc.dart';
import 'src/vehicleController.dart';
import 'src/appConfigure.dart';
import 'src/behaviorTricks.dart';

void main() => runApp(MyApp(title: "RC Remote Control"));

class MyApp extends StatefulWidget {
  MyApp({this.title});

  final String title;

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  ConnectionBloc connectionBloc = ConnectionBloc(
      socket: IO.io("", <String, dynamic>{
    'autoConnect': false,
    'transports': ['websocket']
  }));

  @override
  Widget build(BuildContext context) {
    const title = 'RPi-Car remote control';
    return BlocProvider<ConnectionBloc>(
      create: (BuildContext context) => connectionBloc,
      child: MaterialApp(
        title: title,
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
          '/vehicleControls': (context) => VehicleController(title: title),
          '/appConfig': (context) => AppConfiguration(title: title),
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    connectionBloc.close();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title: "Titulo"});

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
        title: Text('Bienvenido'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 0,
                width: 0,
              ),
              Text(
                  '¡Bienvenido a la aplicación que sirve para controlar un coche construido con la Raspberry!'),
              ElevatedButton(
                child: Text('Comenzar'),
                onPressed: () {
                  Navigator.pushNamed(context, '/vehicleControls');
                },
              ),
              SizedBox(
                height: 0,
                width: 0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    enableRotation();
  }
}
