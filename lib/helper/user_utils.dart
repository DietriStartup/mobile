import 'package:dietri/helper/enums.dart';

class UserUtils {
  static Gender? intToGender(int? genderNumber) {
    switch (genderNumber) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      case 2:
        return Gender.others;
      default:
        return null;
    }
  }

  static int? genderToInt(Gender? gender) {
    switch (gender) {
      case Gender.male:
        return 0;
      case Gender.female:
        return 1;
      case Gender.others:
        return 2;
      default:
        return null;
    }
  }

  static Goals? intToGoal(int goalNumber) {
    switch (goalNumber) {
      case 0:
        return Goals.gainweight;
      case 1:
        return Goals.maintainweight;
      case 2:
        return Goals.looseweight;
      default:
        return null;
    }
  }

  static int? goalToInt(Goals? goals) {
    switch (goals) {
      case Goals.gainweight:
        return 0;
      case Goals.maintainweight:
        return 1;
      case Goals.looseweight:
        return 2;
      default:
        return null;
    }
  }

  static String getWeightString(Weight? weight) {
    switch (weight) {
      case Weight.st:
        return 'st';
      case Weight.lb:
        return 'lb';
      case Weight.kg:
        return 'kg';
      default:
        return 'kg';
    }
  }
}
