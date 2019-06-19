//item list
enum ItemType {
  tankRegular,
  tankTropical,
  tankPressure,
}

//items to be added to shop
class Item{

  ItemType type;
  String name;
  double cost;
  String description;
  bool supportsFresh;
  bool supportsSalt;
  bool supportsFantasy;
  String image;

  Item(ItemType itemType){

    type = itemType;

    switch(itemType){
      case ItemType.tankRegular:
        name = "Fish Tank";
        cost = 200;
        description = "Tank that can support fish from cold climates.";
        image = 'assets/fishTankRegular2.png';
        break;
      case ItemType.tankTropical:
        name = "Tropical Fish Tank";
        cost = 20;
        description = "Tank that can support fish from warm climates.";
        image = 'assets/fishTankTropical2.png';
        break;
      case ItemType.tankPressure:
        name = "Pressurized Fish Tank";
        cost = 30;
        description = "Tank that can support deep sea fish";
        image = 'assets/fishTankPressure2.png';
        break;
    }
  }
}