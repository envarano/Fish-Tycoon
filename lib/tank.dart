import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'fish.dart';
import 'shop.dart';
import 'player.dart';
import 'tank_button.dart';

ImageMap images;

class TankWidget extends StatefulWidget {
  TankWidget({Key key}) : super(key: key);
  @override
  _TankWidgetState createState() => new _TankWidgetState();
}

class _TankWidgetState extends State<TankWidget> {
  bool shopOpened = false;
  bool eggListOpened = false;
  ShopWidget shopWidget = new ShopWidget();
  List<TankSlot> slots;
  static List<TankSlot> tankSlots;
  int visitorDelayTimer;
  Timer timer;

  Future<Null> _loadAssets(AssetBundle bundle) async {
    images = new ImageMap(bundle);

    await images.load(<String>[
      'assets/visitor-0.png',
      'assets/icon-regular2.png',
      'assets/icon-tropical2.png',
      'assets/icon-pressure2.png',
      'assets/empty2.png',
      'assets/placeable.png',
      'assets/fishTankRegular2.png',
      'assets/fishTankTropical2.png',
      'assets/fishTankPressure2.png',
      'assets/visitor-1.png',
      'assets/visitor-2.png',
      'assets/tank-water4.png',
      'assets/goldfish.png',
      'assets/minnow.png',
      'assets/loach.png',
      'assets/zebrafish.png',
      'assets/rubbernose.png',
      'assets/platy.png',
      'assets/dottyback2.png',
      'assets/clownfish.png',
      'assets/dragonette.png',
      'assets/shop-button.png'
    ]);
  }

  void payEntreeFee() {
    Player.money += Player.entryFee;
    tankWorld.buildTree[5] = new Container(
      padding: EdgeInsets.only(bottom: 10.0, left: 90.0),
      alignment: Alignment.bottomCenter,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          createButton(Icons.monetization_on,
              "Shop: \$" + Player.money.toStringAsFixed(2), addShopWidget())
        ],
      ),
    );

    setState(() {});
    visitorDelayTimer = randomInt(((60 / Player.attraction) * 2).round());
    timer.cancel();
    timer = Timer.periodic(
        Duration(seconds: visitorDelayTimer), (Timer t) => payEntreeFee());
  }

  VoidCallback addShopWidget() {
    return () {
      if (shopOpened)
        tankWorld.buildTree.remove(shopWidget);
      else
        tankWorld.buildTree.add(shopWidget);
      shopOpened = !shopOpened;
      setState(() {
        Shop.fishStock.removeRange(0, Shop.fishStock.length);
        // add fish to shop here
        switch (TankWorld.tankNumber) {
          case 1:
            Shop.fishStock.add(new Fish(FishType.goldfish));
            Shop.fishStock.add(new Fish(FishType.minnow));
            Shop.fishStock.add(new Fish(FishType.loach));
            Shop.fishStock.add(new Fish(FishType.rubbernose));
            Shop.fishStock.add(new Fish(FishType.zebradanio));
            Shop.fishStock.add(new Fish(FishType.betta));
            break;
          case 2:
            Shop.fishStock.add(new Fish(FishType.basslet));
            Shop.fishStock.add(new Fish(FishType.clownfish));
            Shop.fishStock.add(new Fish(FishType.dragonette));
            Shop.fishStock.add(new Fish(FishType.lionfish));
            Shop.fishStock.add(new Fish(FishType.catShark));
            break;
          case 3:
            Shop.fishStock.add(new Fish(FishType.blobfish));
            Shop.fishStock.add(new Fish(FishType.anglerfish));
            Shop.fishStock.add(new Fish(FishType.viperfish));
        }
      });
    };
  }

  Widget createButton(IconData icon, String buttonTitle, Function doThis) {
    //final Color tintColor = Colors.black;
    return new FlatButton(
      onPressed: doThis,
      color: Color.fromRGBO(0, 0, 0, 0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //new Icon(icon, color: tintColor),
          new Container(
              child: new Text(
            buttonTitle,
            style: new TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5),
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAssets(rootBundle).then((_) {
      setState(() {
        assetsLoaded = true;
        Fish.image = images;
        visitorDelayTimer = randomInt(((Player.attraction * 2)).round());
        timer = Timer.periodic(
            Duration(seconds: visitorDelayTimer), (Timer t) => payEntreeFee());
        if (slots == null) {
          slots = new List<TankSlot>();
          for (int x = 0; x < 3; x++)
            slots.add(new TankSlot(
                slotNumber: slots.length,
                tankType: TankType.regular,
                tankState: TankState.empty));
        }

        slots[0].onPressed = () {
          if (TankWorld.tankNumber != 1) {
            TankWorld.tankNumber = 1;
            Navigator.pushAndRemoveUntil(
                Player.mainContext,
                MaterialPageRoute(builder: (context) => new TankWidget()),
                ModalRoute.withName('/'));
          }
        };
        tankWorld = new TankWorld(context, slots);
        tankWorld.widgetState = this;
        Shop.tankStateClass = this;
        Shop.tanks = TankWorld.itemSlot;
        if (Shop.tankWorldSlots == null) {
          Shop.tankWorldSlots = TankWorld.itemSlot;
        }
        tankWorld.fish = new List<Fish>();
        tankWorld.buildTree = <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/tank-water4.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new SpriteWidget(tankWorld),
          new Align(
              alignment: new FractionalOffset(slots[0].xPos, slots[0].yPos),
              child: TankWorld.itemSlot[0]),
          new Align(
              alignment: new FractionalOffset(slots[1].xPos, slots[1].yPos),
              child: TankWorld.itemSlot[1]),
          new Align(
              alignment: new FractionalOffset(slots[2].xPos, slots[2].yPos),
              child: TankWorld.itemSlot[2]),
          // new Align(
          //     alignment: Alignment.bottomCenter,
          //     child: new Container(
          //         height: 50,
          //         width: 50,
          //         child: new InkWell(
          //           onTap: addShopWidget(),
          //           child: new FittedBox(
          //             alignment: Alignment.centerRight,
          //             child: Image.asset("shop-button.png", scale: 1),
          //           ),
          //         )))
          // new Align(
          //     alignment: Alignment.bottomLeft,
          //     child: new Image.asset("shop-button.png")),
          new Container(
            padding: EdgeInsets.only(bottom: 10.0, left: 90.0),
            alignment: Alignment.bottomCenter,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                createButton(Icons.monetization_on,
                    "Shop: \$" + Player.money.toString(), addShopWidget())
              ],
            ),
          ),
          // new Container(
          //   padding: EdgeInsets.only(top: 20.0),
          //   alignment: Alignment.topLeft,
          //   child: new BackButton(),
          // )
        ];
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //set to true after images are loaded
  bool assetsLoaded = false;

  //holds information relating to aquarium environment
  TankWorld tankWorld;

  @override
  Widget build(BuildContext context) {
    //if assets fail to load, will show screen as red
    if (!assetsLoaded) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Tank'),
        ),
        body: new Container(
          color: Colors.red,
        ),
      );
    }
    //else will build the tank
    return new Scaffold(
      body: new Material(
        child: new Stack(children: tankWorld.buildTree),
      ),
    );
  }
}

class TankWorld extends NodeWithSize {
  List<Widget> buildTree = <Widget>[];
  List<Fish> fish = <Fish>[];

  //constructor
  TankWorld(BuildContext context, List<TankSlot> slot)
      : super(const Size(2048.0, 2048.0)) {
    moneyText = new Text("Money: " + Player.money.toString(),
        style: new TextStyle(
            color: Colors.red,
            background: Paint()..color = Colors.blue,
            fontSize: 30));

    switch (tankNumber) {
      case 1:
        if (Player.firstTankFish.length == 0)
          Player.firstTankFish.add(new Fish(FishType.minnow));
        fishList = Player.firstTankFish;
        break;
      case 2:
        fishList = Player.secondTankFish;
        break;
      case 3:
        fishList = Player.thirdTankFish;
        break;
    }
    for (int i = 0; i < fishList.length; i++) {
      addChild(new Fish(fishList[i].fishType));
    }

    Shop.tankFish = fishList;

    if (itemSlot == null) {
      itemSlot = <TankButton>[];
      for (int x = 0; x < slot.length; x++) {
        itemSlot.add(
            new TankButton(onPressed: slot[x].onPressed, tankSlot: slot[x]));
      }
    }
  }
  List<Fish> fishList = <Fish>[];
  static List<TankButton> itemSlot;
  static int tankNumber = 1;
  BuildContext widgetContext;
  _TankWidgetState widgetState;
  TankType get tankType => _tankType;
  TankType _tankType = TankType.regular;
  List<Offset> tankLocations = <Offset>[];
  static List<TankButton> tanks;
  BuildContext context;
  bool active = false;
  Text moneyText;
}
