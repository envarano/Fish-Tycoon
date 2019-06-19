import 'package:fish_game/tank.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'aquarium.dart';
import 'player.dart';

void main() => runApp(AquariumApp());

class AquariumApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);


    return new MaterialApp(
      title: 'Aquarium',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new AquariumWidget(),
      routes: <String, WidgetBuilder> {
        '/regularTank': (BuildContext context) => Player.firstTank,
        '/tropicalTank': (BuildContext context) => Player.secondTank,
        '/pressureTank': (BuildContext context) => Player.thirdTank,
      },
    );
  }
}
