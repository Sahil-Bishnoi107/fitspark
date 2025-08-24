import 'package:fitspark/objects/meals.dart';
import 'package:hive_flutter/adapters.dart';

void addMealto(String timename,Meal meal){
  Map<String,dynamic> map = {
    "name":meal.name,"calories":meal.calories,"protein":meal.protein,"fats":meal.fats,"carbs":meal.carbs,"fibre":meal.fibre,
    "quantity":meal.quantity,"quantityFactor": meal.quantityFactor,"quantityUnit": meal.quantityUnit
  };
  final box = Hive.box(timename);
  box.put(meal.name, map);
}

List<Meal> getMeals(String timename){
  List<Meal> m = [];
  final box = Hive.box(timename);
  final keys = box.keys.cast<String>().toList();
  for(var k in keys){
    final temp = box.get(k);
    Meal x = Meal.fromJson(Map<String, dynamic>.from(temp));
    m.add(x);
  }
  return m;
}
void deleteMeal(String mealtime,String mealname){
  final box = Hive.box(mealtime);
  box.delete(mealname);
}

