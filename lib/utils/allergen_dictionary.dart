import '../model/food_allergy.dart';

class AllergenDictionary {
  /// Returns a detailed list of hidden menu keyword triggers
  /// mapped directly to the FoodAllergyCategory enum stricture.
  static List<String> getKeywordsFor(FoodAllergyCategory category) {
    switch (category) {
      case FoodAllergyCategory.cowmilk:
        return [
          'milk', 'cheese', 'butter', 'cream', 'whey', 'yogurt', 'yoghurt', 'mozzarella', 'cheddar',
          'parmesan', 'gouda', 'feta', 'lactose', 'ghee', 'buttermilk', 'casein', 'sauce_mornay', 'béchamel'
        ];

      case FoodAllergyCategory.eggs:
        return [
          'egg', 'eggs', 'mayo', 'mayonnaise', 'meringue', 'aioli', 'hallandaise', 'battered',
          'eggy', 'custard', 'quiche', 'soufflé'
        ];

      case FoodAllergyCategory.fish:
        return [
          'fish', 'salmon', 'tuna', 'hake', 'cod', 'sardine', 'anchovy', 'anchovies', 'trout',
          'haddock', 'sushi', 'calamari sauce', 'worcestershire'
        ];

      case FoodAllergyCategory.garlic:
        return [
          'garlic', 'aioli', 'marinade', 'rub', 'seasoning', 'herb butter'
        ];

      case FoodAllergyCategory.onion:
        return [
          'onion', 'onions', 'shallot', 'shallots', 'chives', 'leek', 'leeks', 
          'chive', 'chives', 'scallion', 'scallions'
        ];

      case FoodAllergyCategory.peanuts:
        return [
          'peanut', 'peanuts', 'groundnut', ' satay', 'arachis oil', 'monkey fruit', 'praline'
        ];

      case FoodAllergyCategory.sesame:
        return [
          'sesame', 'tahini', 'hummus', 'halva', 'gomasio', 'benne'
        ];

      case FoodAllergyCategory.shellfish:
        return [
          'shellfish' , 'prawn', 'prawns', 'shrimp', 'crab', 'lobster', 'mussel', 'mussels',
          'oyster', 'oysters', 'clam', 'clams', 'calamari'
        ];

      case FoodAllergyCategory.soy:
        return [
          'soy', 'soya', 'tofu', 'edamame', 'miso', 'tempeh', 'tamari', 'teriyaki',
          'shoyu', 'lecithin'
        ];

      case FoodAllergyCategory.treenuts:
        return [
          'almond' , 'walnut', 'cashew', 'pecan', 'pistachio', 'hazelnut',
          'macadamia', 'pesto', 'nougat', 'marzipan'
        ];

      case FoodAllergyCategory.wheat:
        return [
          'wheat', 'flour', 'brioche', 'bun', 'bread', 'crumbed', 'battered', 'pasta', 'batter',
          'soy sauce', 'croutons', 'tortilla', 'rye', 'barley', 'semolina'
        ];
      
    }
  }
}