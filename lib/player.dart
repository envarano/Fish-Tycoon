
import "tank.dart";
import "fish.dart";
import 'package:flutter/material.dart';

enum AquariumType {
  garage,
  warehouse,
  aquarium
}

class Player{
  static double attraction = 5.0;
  static double money = 50.0;
  static bool canEarn = true;
  static AquariumType aquariumType = AquariumType.garage;
  static bool firstPlaythrough = true;
  static double entryFee = 2;
  static TankWidget firstTank;
  static TankWidget secondTank;
  static TankWidget thirdTank;
  static List <Fish> firstTankFish = <Fish>[];
  static List <Fish> secondTankFish = <Fish>[];
  static List <Fish> thirdTankFish = <Fish>[];
  static BuildContext mainContext;
}