import 'package:flutter/material.dart';

enum TankState { empty, placeable, placed }

enum TankType { regular, tropical, pressure }

class TankButton extends StatelessWidget {
  TankButton({this.tankSlot, this.onPressed, Key key}) : super(key: key);

  // final String sImage;
  final VoidCallback onPressed;
  // final double size;
  final TankSlot tankSlot;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new FittedBox(
        alignment: Alignment.centerRight,
        child: Image.asset(tankSlot.sImage, scale: 1),
      ),
    );
  }
}

class TankSlot {
  TankSlot({this.slotNumber, this.tankType, this.tankState}) {
    switch (tankType) {
      case TankType.regular:
        sImage = "assets/icon-regular2.png";
        xPos = xPos = 0.01 + slotNumber * 0.12;
        yPos = 0.05;
        size = 50;
        break;
      case TankType.tropical:
        sImage = "assets/icon-tropical2.png";
        xPos = xPos = 0.01 + slotNumber * 0.12;
        yPos = 0.05;
        size = 50;
        break;
      case TankType.pressure:
        sImage = "assets/icon-pressure2.png";
        xPos = xPos = 0.01 + slotNumber * 0.12;
        yPos = 0.05;
        size = 50;
        break;
    }
    if (tankState == TankState.empty && slotNumber != 0) {
      sImage = "assets/empty2.png";
    } else if (tankState == TankState.placeable) {
      sImage = "assets/placeable.png";
      print("setting to placeable");
    }
  }

  TankState tankState = TankState.empty;
  TankType tankType;
  int slotNumber;
  List<TankButton> tankList = <TankButton>[];
  String sImage;
  VoidCallback onPressed;
  double yPos;
  double xPos;
  double size;
}
