import 'package:flutter/material.dart';

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

  var servidor = TextFormField(
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
  var puerto = TextFormField(
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

  var conectar = RaisedButton(
    onPressed: () {},
    child: Text("Conectar"),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[servidor, puerto, conectar],
      ),
    );
  }
}
