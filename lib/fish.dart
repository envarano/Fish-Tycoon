import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import "player.dart";

enum FishType {
  goldfish,
  minnow,
  loach,
  rubbernose,
  zebradanio,
  betta,

  clownfish,
  lionfish,
  catShark,
  basslet,
  dragonette,

  anglerfish,
  blobfish,
  viperfish
}

enum MovementType { normal, hungry, bottomDwell }

class Fish extends Node {
  Offset dest = Offset.zero;
  bool negX = false;
  bool negY = false;
  double speedX = 0.0;
  double speedY = 0.0;
  double nSpeedX = 0.0;
  double nSpeedY = 0.0;
  double slowSpeedX = 0.0;
  double slowSpeedY = 0.0;
  double slowNSpeedX = 0.0;
  double slowNSpeedY = 0.0;

  int speedMultiplier = 0;

  String name;
  double attraction;
  double impression;
  String picture = 'assets/coralStaghorn.png';
  int cost;
  int sellPrice;
  ui.Image imageName;
  double sizeMultiplier = 1.0;
  //*Todo: Change to real DEVICE_HEIGHT and DEVICE_WIDTH
  double deviceWidth = 650;
  double deviceHeight = 250;
  static ImageMap image;
  FishType fishType;

  Fish(this.fishType) {
    switch (fishType) {
      case FishType.goldfish:
        picture = 'assets/goldfish.png';
        imageName = image['assets/goldfish.png'];
        name = "Goldfish";
        cost = 2;
        sellPrice = 2;
        speedMultiplier = 150;
        sizeMultiplier = 1;
        attraction = 0.1;
        impression = 0.5;
        break;
      case FishType.minnow:
        picture = 'assets/minnow.png';
        imageName = image['assets/minnow.png'];
        name = "Tetra";
        cost = 4;
        sellPrice = 25;
        speedMultiplier = 40;
        sizeMultiplier = 1;
        attraction = 0.2;
        impression = 0.6;
        break;
      case FishType.rubbernose:
        picture = 'assets/rubbernose.png';
        imageName = image['assets/rubbernose.png'];
        name = "Axolotl";
        cost = 6;
        sellPrice = 100;
        speedMultiplier = 300;
        sizeMultiplier = 1;
        attraction = 0.5;
        impression = 1;
        movementType = MovementType.bottomDwell;
        break;
      case FishType.loach:
        picture = 'assets/loach.png';
        imageName = image['assets/loach.png'];
        name = "Angelfish";
        cost = 7;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 0.4;
        impression = 0.9;
        movementType = MovementType.bottomDwell;
        break;
      case FishType.zebradanio:
        picture = 'assets/zebrafish.png';
        imageName = image['assets/zebrafish.png'];
        name = "Betta";
        cost = 10;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 0.3;
        impression = 0.7;
        break;
      case FishType.betta:
        picture = 'assets/platy.png';
        imageName = image['assets/platy.png'];
        name = "Suckerfish";
        cost = 15;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 0.6;
        impression = 0.8;
        break;
        case FishType.basslet:
        picture = 'assets/dottyback2.png';
        imageName = image['assets/dottyback2.png'];
        name = "Basslet";
        cost = 20;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 1;
        impression = 1.5;
        break;
      case FishType.clownfish:
        picture = 'assets/clownfish.png';
        imageName = image['assets/clownfish.png'];
        name = "Clownfish";
        cost = 25;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 1;
        impression = 2;
        break;
      case FishType.dragonette:
      picture = 'assets/dragonette.png';
        imageName = image['assets/dragonette.png'];
        name = "Dragonette";
        cost = 50;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 2;
        impression = 4;
        break;
      case FishType.lionfish:
        imageName = image['assets/visitor-0.png'];
        name = "Lionfish";
        cost = 100;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 2;
        impression = 5;
        break;
      case FishType.catShark:
        imageName = image['assets/visitor-0.png'];
        name = "Cat Shark";
        cost = 200;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 3;
        impression = 10;
        break;
      case FishType.anglerfish:
        imageName = image['assets/visitor-0.png'];
        name = "Anglerfish";
        cost = 5000;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 10;
        impression = 20;
        break;
      case FishType.blobfish:
        imageName = image['assets/visitor-0.png'];
        name = "Blobfish";
        cost = 500;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 5;
        impression = 15;
        break;
      case FishType.viperfish:
        imageName = image['assets/visitor-0.png'];
        name = "Viper fish";
        cost = 50000;
        sellPrice = 150;
        speedMultiplier = 80;
        sizeMultiplier = 1;
        attraction = 15;
        impression = 30;
        break;
      default:
    }

    _sprites.add(_createSprite(imageName));
    if (movementType != MovementType.bottomDwell) {
      _sprites[0].position = const Offset(1024.0, 1024.0);
    } else {
      _sprites[0].position = const Offset(1024.0, 1464.0);
    }
    addChild(_sprites[0]);
  }

  bool headingWest = false;
  bool headingEast = false;
  bool headingSouth = false;
  bool headingNorth = false;
  bool alive = true;
  double xPrev = 0;
  double yPrev = 0;
  int health = 100;
  int hungerHourDifference;
  MovementType movementType = MovementType.normal;

  @override
  update(double dt) {
    //if the destination has not been set (dest is reset to 0 once reached)
    if (dest == Offset.zero) {
      //set speedModifier higher to slow down fish
      int speedModifier = 1 * speedMultiplier;

      //*Todo: Later on these values should be relative to real DEVICE_WIDTH and DEVICE_HEIGHT,
      double speedCapX = deviceWidth / speedModifier;
      double speedCapY = deviceHeight / speedModifier;
      double speedCapNX = 0 - deviceWidth / speedModifier;
      double speedCapNY = 0 - deviceHeight / speedModifier;

      //new target destination

      if (movementType != MovementType.bottomDwell) {
        dest = new Offset(deviceWidth * randomSignedDouble(),
            deviceHeight * randomSignedDouble());
      } else {
        dest = new Offset(deviceWidth * randomSignedDouble(), 0);
      }

      ///speed of fish, nSpeed is negative for neg offsets
      ///(you can do this inline instead, but this is faster, just more bloated)
      speedX = (dest.dx - position.dx).abs() / 30;
      speedY = (dest.dy - position.dy).abs() / 30;
      nSpeedX = 0 - speedX;
      nSpeedY = 0 - speedY;

      ////Slows down fish instead of halting if they reach a Y or X coord first.
      ///Not necessary, can set to 0 inline instead if you want
      // slowSpeedX = 0.2;
      // slowSpeedY = 0.2;
      slowNSpeedX = -0.2;
      slowNSpeedY = -0.2;

      ///Fish will always take the same amount of frames to reach dest
      ///capping their speed looks nicer (you might be able to just increase
      ///number that the position difference is divided by instead - line 281)
      if (speedX > speedCapX) speedX = speedCapX;
      if (speedY > speedCapY) speedY = speedCapY;
      if (nSpeedX < speedCapNX) nSpeedX = speedCapNX;
      if (nSpeedY < speedCapNY) nSpeedY = speedCapNY;
    }

    ///4 if statements to check whether fish destination is NE, NW, SE or SW
    ///I went for readability on these, these can be made more efficient if
    ///needed, can be turned into switch-case to stop first if statement being
    ///needed, also first 2 if statements being inside the else will make it
    ///run faster.

    //if SW: x and y destination are both in negative direction
    if (dest.dx.isNegative && dest.dy.isNegative) {
      if (position.dx <= dest.dx)
        nSpeedX = slowNSpeedX; //if x has been reached, slow speed
      if (position.dy <= dest.dy)
        nSpeedY = slowNSpeedY; //if y has been reached, slow speed
      //if both coords have been reached, set dest to 0 so that it gets updated in first if()
      if (position.dx <= dest.dx && position.dy <= dest.dy)
        dest = Offset.zero;
      //if both coords have not been reached, move position of sprite by our set speed
      else
        position += new Offset(nSpeedX, nSpeedY);
    }
    //if NW: x dest is negative, y dest is positive
    else if (dest.dx.isNegative && !dest.dy.isNegative) {
      if (position.dx <= dest.dx)
        nSpeedX = slowNSpeedX; //if x has been reached, slow speed
      if (position.dy >= dest.dy)
        speedY = slowSpeedY; //if y has been reached, slow speed
      //if both coords have been reached, set dest to 0 so that it gets updated in first if()
      if (position.dx <= dest.dx && position.dy >= dest.dy)
        dest = Offset.zero;
      //if both coords have not been reached, move position of sprite by our set speed
      else
        position += new Offset(nSpeedX, speedY);
    }
    //if SE: x dest is positive, y dest is negative
    else if (!dest.dx.isNegative && dest.dy.isNegative) {
      if (position.dx >= dest.dx)
        speedX = slowSpeedX; //if x has been reached, slow speed
      if (position.dy <= dest.dy)
        nSpeedY = slowNSpeedY; //if y has been reached, slow speed
      //if both coords have been reached, set dest to 0 so that it gets updated in first if()
      if (position.dx >= dest.dx && position.dy <= dest.dy)
        dest = Offset.zero;
      //if both coords have not been reached, move position of sprite by our set speed
      else
        position += new Offset(speedX, nSpeedY);
    }
    //if NE: x dest is positive, y dest is positive
    else if (!dest.dx.isNegative && !dest.dy.isNegative) {
      if (position.dx >= dest.dx)
        speedX = slowSpeedX; //if x has been reached, slow speed
      if (position.dy >= dest.dy)
        speedY = slowSpeedY; //if y has been reached, slow speed
      //if both coords have been reached, set dest to 0 so that it gets updated in first if()
      if (position.dx >= dest.dx && position.dy >= dest.dy)
        dest = Offset.zero;
      //if both coords have not been reached, move position of sprite by our set speed
      else
        position += new Offset(speedX, speedY);
    }

    if (position.dx > xPrev) {
      headingEast = true;
    } else if (position.dx < xPrev) {
      headingWest = true;
    }
    if (position.dy > yPrev) {
      headingSouth = true;
    } else if (position.dy < yPrev) {
      headingNorth = true;
    }

    // if (headingNorth) _sprites[0].rotation = 0.0;

    if (headingEast)
      _sprites[0].scaleX = -1;
    else
      _sprites[0].scaleX = 1;
    // else if (headingSouth) _sprites[0].rotation = 180.0;
    //else if (headingWest) _sprites[0].rotation = 270.0;

    // if (headingNorth && headingEast){
    //   _sprites[0].rotation = 45.0 - ((xPrev - position.dx) - (yPrev - position.dy));
    // }
    // else if (headingNorth && headingWest){
    //   _sprites[0].rotation = 315.0 + ((xPrev - position.dx) - (yPrev - position.dy));
    // }
    // else if (headingSouth && headingEast){
    //   _sprites[0].rotation = 135.0 + ((xPrev - position.dx) - (yPrev - position.dy));
    // }
    // else if (headingSouth && headingWest){
    //   _sprites[0].rotation = 225.0 - ((xPrev - position.dx) - (yPrev - position.dy));
    // }

    headingWest = false;
    headingEast = false;
    headingSouth = false;
    headingNorth = false;
    xPrev = position.dx;
    yPrev = position.dy;
  }

  List<Sprite> _sprites = <Sprite>[];

  Sprite _createSprite(ui.Image image) {
    Sprite sprite = new Sprite.fromImage(image);

    return sprite;
  }

  set active(bool active) {
    double opacity;
    if (active)
      opacity = 1.0;
    else
      opacity = 0.0;

    for (Sprite sprite in _sprites) {
      sprite.actions.stopAll();
      sprite.actions.run(new ActionTween<double>(
          (a) => sprite.opacity = a, sprite.opacity, opacity, 1.0));
    }
  }
}
