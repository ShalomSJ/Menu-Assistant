import 'package:isar/isar.dart';

part 'food_allergy.g.dart';

enum FoodAllergyCategory {
  cowmilk,
  eggs,
  peanuts,
  treenuts,
  soy,
  wheat,
  fish,
  shellfish,
  sesame,
  garlic,
  onion,
}

@collection
class FoodAllergy {
  Id id = Isar.autoIncrement;

  late String name;

  @enumerated
  late FoodAllergyCategory allergyCategory;

  FoodAllergy({
    required this.id,
    required this.name,
    required this.allergyCategory,
  });


}