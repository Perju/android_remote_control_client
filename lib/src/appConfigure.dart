import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/connection_bloc.dart';
import "./bloc/connection_event.dart";

class AppConfiguration extends StatelessWidget {
  AppConfiguration({Key key, this.title}) : super(key: key);

  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        leading: IconButton(
          icon: Icon(Icons.drive_eta),
          onPressed: () {
            Navigator.pushNamed(context, '/vehicleControls');
          },
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 480,
          child: ConfigForm(),
        ),
      ),
    );
  }
}

class ConfigForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfigFormState();
  }
}

class ConfigFormState extends State<ConfigForm> {
  final _formKey = GlobalKey<FormState>();

  static const decoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
  );

  static var servidor = TextFormField(
    controller: TextEditingController(),
    decoration: decoration.copyWith(
      labelText: "Dirección IP",
      hintText: "192.xxx.xxx.xxx",
    ),
    validator: (value) {
      if (value.isEmpty) {
        return 'Campo vacío';
      }
      return null;
    },
  );

  static var puerto = TextFormField(
    controller: TextEditingController(),
    decoration: decoration.copyWith(
      labelText: "Puerto",
      hintText: "4000",
    ),
    validator: (value) {
      if (value.isEmpty) {
        return 'Campo vacío';
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    final connectionBloc = BlocProvider.of<ConnectionBloc>(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          servidor,
          puerto,
          RaisedButton(
            onPressed: () {
              String url = _generateUrlConnection(
                  servidor.controller.text, puerto.controller.text);
              if (url != "error") {
                connectionBloc.socket.io.uri = url;
                connectionBloc.add(Connect());
              }
            },
            child: Text("Conectar"),
          )
        ],
      ),
    );
  }
}

String _generateUrlConnection(String ip, String port) {
  if (ip != null && port != null) {
    return "http://${ip}:${port}";
  } else {
    return "error";
  }
}

/// Regexps para comprobar la ip el puerto
// final RegExp ipRegExp = new RegExp(
//   r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}",
// );

// final RegExp portRegExp = new RegExp(r"^\d{1,5}");
