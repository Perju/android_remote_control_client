import 'package:flutter/material.dart';
import 'behaviorTricks.dart';
class VehicleController extends StatefulWidget {
  _VehicleControllerState createState() => _VehicleControllerState();
}
class _VehicleControllerState extends State<VehicleController> {
  @override
  initState(){
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
        child: Row(children: <Widget>[
          Text('¡hola mundo!'),
          RaisedButton(child: Text('Volver'),onPressed: (){
            Navigator.pop(context);
          },)
          ],
        ),
      ),
    );
  }
  @override
  void dispose(){
    super.dispose();
    enableRotation();
  }
}