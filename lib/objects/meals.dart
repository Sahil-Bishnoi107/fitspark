class Meal {
  String name;
  int calories;
  double protein;
  double carbs;
  double fats;
  double fibre;
  double quantity;
  String quantityUnit;
  double quantityFactor;
  double small;
  double medium;
  double big;
  String type;

  Meal({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.fibre,
    required this.quantity,
    required this.quantityUnit,
    required this.quantityFactor,
    required this.small,
    required this.medium,
    required this.big,
    required this.type
  });

  factory Meal.fromJson(Map<String, dynamic> map) {
    return Meal(
      name: map.containsKey('name') ? map['name'] : 'error',
      calories: map.containsKey('calories') ? map['calories'] : 0,
      protein: (map['protein'] ?? 0).toDouble(),
      carbs: (map['carbs'] ?? 0).toDouble(),
      fats: (map['fats'] ?? 0).toDouble(),
      fibre: (map['fibre'] ?? 0).toDouble(),
      quantity: (map['quantity'] ?? 1).toDouble(),
      quantityUnit: map['quantityUnit'] ?? 'grams',
      quantityFactor: (map['quantityFactor'] ?? 1).toDouble(),
      small: (map['small'] ?? 50).toDouble(),
      medium: (map['medium'] ?? 100).toDouble(),
      big: (map['big'] ?? 200).toDouble(),
      type: (map['type'] ?? "a")
    );
  }
}
