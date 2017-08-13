import "SBURBClass.dart";
import "../../Player.dart";
import "../../GameEntity.dart";
class Mage extends SBURBClass {
  Mage() : super("Mage", 3, true);

  @override
  num  modPowerBoostByClass(num powerBoost, AssociatedStat stat) {
    if (stat.multiplier > 0) {
      powerBoost = powerBoost * 2;
    } else {
      powerBoost = powerBoost * 2.5;
    }
    return powerBoost;
  }

}