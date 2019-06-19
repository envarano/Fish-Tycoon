import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:core';
import 'dart:io';
import 'player.dart';
import 'shop.dart';
import 'cutscene.dart';
import 'tank.dart';
import 'package:path_provider/path_provider.dart';

ImageMap _images;

class AquariumWidget extends StatefulWidget {
  AquariumWidget({Key key}) : super(key: key);

  @override
  _AquariumWidgetState createState() => new _AquariumWidgetState();
}

//Widget state
class _AquariumWidgetState extends State<AquariumWidget> {
  CutSceneWidget cutSceneWidget;
  bool assetsLoaded = false;
  List<Widget> buildTree = <Widget>[];
  Future<bool> fileCheck;
  bool hasSaveFile;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/player.txt');
  }

  Future<File> writePlayer() async {
    final file = await _localFile;
    print("file will read: " + Player.firstPlaythrough.toString());
    return file.writeAsString(Player.firstPlaythrough.toString());
  }

  Future<bool> readPlayer() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      bool result = contents.toLowerCase() == 'true';
      hasSaveFile = result;
      print("read player: " + hasSaveFile.toString());
      return (result);
    } catch (e) {
      print("error: failed to read file, attempting to write file...");
      writePlayer();
      return false;
    }
  }

  Future<Null> _loadAssets(AssetBundle bundle) async {
    _images = new ImageMap(bundle);

    await _images.load(<String>[
      'assets/garage.png',
      'assets/store.png',
      'assets/warehouse.png',
      'assets/aquarium.png',
      'assets/shopItemBackground.png',
      'assets/coralStaghorn.png',
      'assets/coralLettuce.png',
      'assets/cutscene-lightsoff.png',
    ]);
  }

  //initState is called once for each state change
  @override
  void initState() {
    super.initState();
    _loadAssets(rootBundle).then((_) {
      setState(() {
        readPlayer().then((_) {
          setState(() {
            fileCheck = readPlayer();
            Player.firstPlaythrough = hasSaveFile;
            // if (Player.firstPlaythrough) {
              buildTree.add(cutSceneWidget);
            // }
            // else{
            TankWidget firstTank = new TankWidget();
            Player.firstTank = firstTank;
            Player.mainContext = context;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => cutSceneWidget));
            // }
          });
        });
        // if(Player.firstPlaythrough){
        cutSceneWidget = new CutSceneWidget();
        // }
        assetsLoaded = true;
        Shop.addStartStock();
        Tutorial.stateClass = this;
        //Reference to displayed widgets
        buildTree = <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          )
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //if assets fail to load, will show screen as red
    if (!assetsLoaded) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Aquarium'),
        ),
        body: new Container(
          decoration: new BoxDecoration(
            color: const Color(0xffff0000),
          ),
        ),
      );
    } else
      return new Scaffold(
        body: new Material(
          child: new Stack(
            children: buildTree,
          ),
        ),
      );
  }
}
