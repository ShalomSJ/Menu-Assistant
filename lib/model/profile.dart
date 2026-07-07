import 'package:isar/isar.dart';
import 'food_allergy.dart';

part 'profile.g.dart';

@collection
class Profile {
  // TO AUTO INCREMENT THE ID
  Id id = Isar.autoIncrement;

  late String name;

  @Enumerated(EnumType.name)
  late List<FoodAllergyCategory> allergyCategory;

  Profile({
    required this.id,
    required this.name,
    required this.allergyCategory,
  });
}