import 'fish.dart';
import 'package:flutter/material.dart';
import 'item.dart';
import 'player.dart';
import 'tank_button.dart';
import 'tank.dart';

enum TabType { fish, item }

class ShopWidget extends StatefulWidget {
  ShopWidget({Key key}) : super(key: key);

  //create state function
  @override
  _ShopWidgetState createState() => new _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  Shop shop;
  List<Column> fishImages = <Column>[];
  List<Column> itemImages = <Column>[];

  @override
  void initState() {
    super.initState();
    for (var fish in Shop.fishStock) {
      fishImages.add(new Column(children: <Widget>[
        new Container(
            height: 75,
            width: 75,
            child: new DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/shopItemBackground.png'),
                        fit: BoxFit.fill)),
                child: Center(
                  child: Image.asset(fish.picture),
                ))),
        new RaisedButton(onPressed: buyFish(fish), child: Text("Buy"))
      ]));
    }
    for (var item in Shop.stock) {
      itemImages.add(new Column(children: <Widget>[
        new Container(
            height: 75,
            width: 75,
            child: new DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/shopItemBackground.png'),
                        fit: BoxFit.fill)),
                child: Center(
                  child: Image.asset(item.image),
                ))),
        new RaisedButton(onPressed: buyItem(item), child: Text("Buy"))
      ]));
    }
  }

  VoidCallback updateTab() {
    return () {
      setState(() {
        Shop.tabType = TabType.item;
      });
    };
  }

  VoidCallback buyItem(var item) {
    return () {
      if (Player.money >= item.cost) {
        setState(() {
          Player.money -= item.cost;

          switch (item.type) {
            case ItemType.tankRegular:
              buyTank(TankType.regular, item);
              break;
            case ItemType.tankTropical:
              buyTank(TankType.tropical, item);
              break;
            case ItemType.tankPressure:
              buyTank(TankType.pressure, item);
              break;
            default:
              print("no type");
              break;
          }
        });
      }
    };
  }

  VoidCallback buyFish(var fish) {
    return () {
      int tankSize;
      switch (TankWorld.tankNumber) {
        case 1:
          tankSize = Player.firstTankFish.length;
          break;
        case 2:
          tankSize = Player.secondTankFish.length;
          break;
        case 3:
          tankSize = Player.thirdTankFish.length;
          break;
      }
      bool capacityUnreached = (tankSize < 6);
      if (Player.money >= fish.cost && capacityUnreached) {
        setState(() {
          Player.money -= fish.cost;
          Player.attraction += fish.attraction;
          Player.entryFee += fish.impression;
          Player.entryFee = num.parse(Player.entryFee.toStringAsFixed(2));

          switch (fish.fishType) {
            case FishType.goldfish:
              Fish goldfish = new Fish(FishType.goldfish);
              Shop.tankStateClass.tankWorld.addChild(goldfish);
              Shop.tankStateClass.tankWorld.fishList.add(goldfish);
              break;
            case FishType.minnow:
              Fish axolotl = new Fish(FishType.minnow);
              Shop.tankStateClass.tankWorld.addChild(axolotl);
              Shop.tankStateClass.tankWorld.fishList.add(axolotl);
              break;
            case FishType.loach:
              Fish angelfish = new Fish(FishType.loach);
              Shop.tankStateClass.tankWorld.addChild(angelfish);
              Shop.tankStateClass.tankWorld.fishList.add(angelfish);
              break;
            case FishType.betta:
              Fish betta = new Fish(FishType.betta);
              Shop.tankStateClass.tankWorld.addChild(betta);
              Shop.tankStateClass.tankWorld.fishList.add(betta);
              break;
            case FishType.rubbernose:
              Fish tetra = new Fish(FishType.rubbernose);
              Shop.tankStateClass.tankWorld.addChild(tetra);
              Shop.tankStateClass.tankWorld.fishList.add(tetra);
              break;
            case FishType.zebradanio:
              Fish suckerfish = new Fish(FishType.zebradanio);
              Shop.tankStateClass.tankWorld.addChild(suckerfish);
              Shop.tankStateClass.tankWorld.fishList.add(suckerfish);
              break;
            case FishType.clownfish:
              Fish clownfish = new Fish(FishType.clownfish);
              Shop.tankStateClass.tankWorld.addChild(clownfish);
              Shop.tankStateClass.tankWorld.fishList.add(clownfish);
              break;
            case FishType.basslet:
              Fish basslet = new Fish(FishType.basslet);
              Shop.tankStateClass.tankWorld.addChild(basslet);
              Shop.tankStateClass.tankWorld.fishList.add(basslet);
              break;
            case FishType.dragonette:
              Fish dragonette = new Fish(FishType.dragonette);
              Shop.tankStateClass.tankWorld.addChild(dragonette);
              Shop.tankStateClass.tankWorld.fishList.add(dragonette);
              break;
            case FishType.lionfish:
              Fish lionfish = new Fish(FishType.lionfish);
              Shop.tankStateClass.tankWorld.addChild(lionfish);
              Shop.tankStateClass.tankWorld.fishList.add(lionfish);
              break;
            case FishType.catShark:
              Fish catShark = new Fish(FishType.catShark);
              Shop.tankStateClass.tankWorld.addChild(catShark);
              Shop.tankStateClass.tankWorld.fishList.add(catShark);
              break;
            case FishType.blobfish:
              Fish blobfish = new Fish(FishType.blobfish);
              Shop.tankStateClass.tankWorld.addChild(blobfish);
              Shop.tankStateClass.tankWorld.fishList.add(blobfish);
              break;
            case FishType.anglerfish:
              Fish anglerfish = new Fish(FishType.anglerfish);
              Shop.tankStateClass.tankWorld.addChild(anglerfish);
              Shop.tankStateClass.tankWorld.fishList.add(anglerfish);
              break;
            case FishType.viperfish:
              Fish viperfish = new Fish(FishType.viperfish);
              Shop.tankStateClass.tankWorld.addChild(viperfish);
              Shop.tankStateClass.tankWorld.fishList.add(viperfish);
              break;
          }
          updateTankState();
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment.centerRight,
      child: new DefaultTabController(
          length: 2,
          child: new Container(
              width: 300,
              height: 400,
              color: Color.fromARGB(255, 0, 130, 110),
              child: new Column(
                children: <Widget>[
                  new TabBar(
                    tabs: [
                      Tab(text: "Fish"),
                      Tab(text: "Items"),
                    ],
                  ),
                  new Container(
                      color: Color.fromARGB(255, 0, 110, 95),
                      height: 300,
                      width: 280,
                      child: new TabBarView(
                        children: <Widget>[
                          new GridView(
                            children: fishImages,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5.0),
                          ),
                          new GridView(
                            children: itemImages,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5.0),
                          ),
                        ],
                      ))
                ],
              ))),
    );
  }

  void updateTankState() {
    Shop.tankStateClass.setState(() {
      for (int i = 0; i < Shop.tanks.length; i++) {
        Shop.tankStateClass.tankWorld.buildTree[i + 2] = new Align(
            alignment: new FractionalOffset(Shop.tankStateClass.slots[i].xPos,
                Shop.tankStateClass.slots[i].yPos),
            child: Shop.tanks[i]);
      }
      Shop.tankStateClass.tankWorld.buildTree[5] = new Container(
            padding: EdgeInsets.only(bottom: 10.0, left: 90.0),
            alignment: Alignment.bottomCenter,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Shop.tankStateClass.createButton(Icons.monetization_on,
                    "Shop: \$" + Player.money.toString(), Shop.tankStateClass.addShopWidget())
              ],
            ),
          );
    });
  }

  //creates new tank with bought values
  void buyTank(TankType buyType, Item item) {
    if (buyType == TankType.tropical) {
      if (Shop.tanks[1].tankSlot.tankState == TankState.empty) {
        Shop.tanks[1].tankSlot.tankType = buyType;
        TankWidget secondTank = new TankWidget();
        Player.secondTank = secondTank;
        Shop.tanks[1].tankSlot.tankState = TankState.placed;

        TankSlot ts = new TankSlot(
            slotNumber: Shop.tanks[1].tankSlot.slotNumber,
            tankType: Shop.tanks[1].tankSlot.tankType,
            tankState: TankState.placed);

        ts.onPressed = () {
          if (TankWorld.tankNumber != 2) {
            TankWorld.tankNumber = 2;
            Navigator.pushAndRemoveUntil(
                Player.mainContext,
                MaterialPageRoute(builder: (context) => new TankWidget()),
                ModalRoute.withName('/'));
          }
        };

        Shop.tanks[1] = new TankButton(onPressed: ts.onPressed, tankSlot: ts);
        Shop.tanks[Shop.tanks[1].tankSlot.slotNumber] = Shop.tanks[1];
        Shop.updateTanks = true;
      }
    } else if (buyType == TankType.pressure) {
      if (Shop.tanks[2].tankSlot.tankState == TankState.empty) {
        Shop.tanks[2].tankSlot.tankType = buyType;
        TankWidget thirdTank = new TankWidget();
        Player.thirdTank = thirdTank;
        Shop.tanks[2].tankSlot.tankState = TankState.placed;

        TankSlot ts = new TankSlot(
            slotNumber: Shop.tanks[2].tankSlot.slotNumber,
            tankType: Shop.tanks[2].tankSlot.tankType,
            tankState: TankState.placed);

        ts.onPressed = () {
          if (TankWorld.tankNumber != 3) {
            TankWorld.tankNumber = 3;
            Navigator.pushAndRemoveUntil(
                Player.mainContext,
                MaterialPageRoute(builder: (context) => new TankWidget()),
                ModalRoute.withName('/'));
          }
        };
        Shop.tanks[2] = new TankButton(onPressed: ts.onPressed, tankSlot: ts);
        Shop.tanks[Shop.tanks[2].tankSlot.slotNumber] = Shop.tanks[2];
        Shop.updateTanks = true;
      }
    }
    Shop.stock.remove(item);
    updateTankState();
  }
}

class Shop {
  Shop();
  static List<Fish> fishStock = <Fish>[];
  static List<Item> stock = <Item>[];
  static TabType tabType;
  static List<TankButton> tanks = <TankButton>[];
  static BuildContext aquaContext;
  static bool updateTanks;
  static var stateClass;
  static var tankStateClass;
  static var tankWorldSlots;
  static List<Fish> tankFish = <Fish>[];
  static BuildContext tankContext;
  static BuildContext mainContext;

  static void addStartStock() {
    stock.add(new Item(ItemType.tankTropical));
    stock.add(new Item(ItemType.tankPressure));
  }
}
