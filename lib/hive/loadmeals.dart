import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitspark/objects/meals.dart';
import 'package:hive_flutter/hive_flutter.dart';

void loadMeals() async{
  final box = Hive.box('meals');
  final list = await FirebaseFirestore.instance.collection('meals').get();
  for(var x in list.docs){
    final meal = x.data() as Map<String,dynamic>;
    final name = meal.containsKey('name') ? meal['name']  : "error";
    final calories = meal.containsKey('calories') ? meal['calories']  : 0;
    final protein = meal.containsKey('protein') ? meal['protein']  : 0.0;
    final fats = meal.containsKey('fats') ? meal['fats']  : 0.0;
    final carbs = meal.containsKey('carbs') ? meal['carbs']  : 0.0;
    final fibre = meal.containsKey('fibre') ? meal['fibre']  : 0.0;
    final small = meal.containsKey('small') ? meal['small']  : 50;
    final medium = meal.containsKey('medium') ? meal['medium']  : 100;
    final big = meal.containsKey('big') ? meal['big']  : 0.0;
    final type = meal.containsKey('type') ? meal['type']  : "a";
    Map<String,dynamic> doc = {
      "name" : name, "calories" : calories,"protein" : protein,"fats" : fats,"carbs" : carbs,"fibre" : fibre,
      "small":small,"medium":medium,"big":big,"type":type
    };
    box.put(name, doc);
  }
}
List<String> searchOptions(String text){
  List<String> temp = [];
  final box = Hive.box('meals');
  final keys = box.keys.cast<String>().toList();
  for(var x in keys){
    if(x.toLowerCase().contains(text.toLowerCase())){temp.add(x);}
  }
  return temp;
}