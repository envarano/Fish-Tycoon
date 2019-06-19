import 'package:fish_game/player.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'tank.dart';

class CutSceneWidget extends StatefulWidget {
  @override
  _CutSceneWidgetState createState() => new _CutSceneWidgetState();
}

class _CutSceneWidgetState extends State<CutSceneWidget> {
  var pageNumber = 1;

  AssetImage newImage() {
    switch (pageNumber) {
      case 1:
        return new AssetImage("assets/cutscene-lightsoff.png");
      case 2:
        return new AssetImage("assets/cutscene-lightsoff.png");
      case 3:
        return new AssetImage("assets/aquarium.png");
    }
    return new AssetImage("assets/coralStaghorn.png");
  }

  String newText() {
    switch (pageNumber) {
      case 2:
        return '"Happy Birthday!"';
      case 3:
        return "*You open your eyes to see a figure standing in the dark*";
      case 4:
        return '*The figure flicks on the lights*';
      case 5:
        return '"... Thanks Dad."';
      case 6:
        return 'Dad: "I thought I\'d give you your present before I head off to work."';
      case 7:
        return '"So where is it?"';
      case 8:
        return '*He gestures towards the other side of your room*';
      case 9:
        return '"... A fish?"';
      case 10:
        return 'Dad: "And a tank! That\'s not just any fish either, it\'s a one of a kind blue goldfish."';
      case 11:
        return '"... So it\'s not a goldfish?"';
      case 12:
        return 'Dad: "... Well it\'s a goldfish... But it\'s blue."';
      case 13:
        return 'Dad: "Take care of it. It\'s very valuable, you can\'t expect to take over our aquarium one day if you can\'t even take care of this fish!"';
      case 14:
        return 'Dad: "Anyway, I\'m off, Cya!"';
      case 15:
        return '"Bye! Thanks dad!"';
      case 16:
        return 'So he thinks I can barely take care of a fish. I\'ll show him just how easy it is to run an aquarium.';
      case 17:
        return 'I\'ll set up in our storage unit.';
    }
    return "Test";
  }

  List<Widget> buildTree;
  @override
  void initState() {
    super.initState();
    setState(() {
      VoidCallback nextPage() {
        return () {
          if (pageNumber >= 17) {
            TankWidget firstTank = new TankWidget();
            Player.firstTank = firstTank;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => firstTank));
          }

          Tutorial.stateClass.setState(() {
            setState(() {
              pageNumber++;
              buildTree[1] = new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                        padding: EdgeInsets.all(40),
                        child: new Text(
                          newText(),
                          style: new TextStyle(fontSize: 30),
                        )),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new RaisedButton(
                          child: Text("Next"),
                          onPressed: nextPage(),
                        )
                      ],
                    )
                  ]);
              buildTree[0] = new Container(
                decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: newImage(), fit: BoxFit.cover)),
              );
            });
          });
        };
      }

      buildTree = <Widget>[
        new Container(
          decoration: BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/aquarium.png"),
                  fit: BoxFit.cover)),
        ),
        new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.all(40),
                  child: new Text(
                    '"Happy Birthday!"',
                    style: new TextStyle(fontSize: 30),
                  )),
              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    child: Text("Next"),
                    onPressed: nextPage(),
                  )
                ],
              )
            ])
      ];
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return new Scaffold(
        body: new Material(child: new Stack(children: buildTree)));
  }
}

class Tutorial {
  static var stateClass;
}
