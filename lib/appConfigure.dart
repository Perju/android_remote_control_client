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
    );
  }
}
