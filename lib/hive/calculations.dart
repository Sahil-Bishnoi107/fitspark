import 'package:hive/hive.dart';

int totalCalories(){
  double cal = 0;
  List<String> x = ['breakfast','lunch','dinner','snacks'];
  for(var i in x){
    final box1 = Hive.box(i);
    final keys = box1.keys.cast<String>().toList();
    for(var k in keys){
      final temp = box1.get(k);
      cal += temp['calories']*temp['quantity']*temp['quantityFactor']/100 ;
    }
  }
  return cal.toInt();
}
double totalProtein(){
  double pro = 0;
  List<String> x = ['breakfast','lunch','dinner','snacks'];
  for(var i in x){
    final box1 = Hive.box(i);
    final keys = box1.keys.cast<String>().toList();
    for(var k in keys){
      final temp = box1.get(k);
      pro += temp['protein']*temp['quantity']*temp['quantityFactor']/100 ;
    }
  }
  return pro;
}

double totalFibre(){
  double fib = 0;
  List<String> x = ['breakfast','lunch','dinner','snacks'];
  for(var i in x){
    final box1 = Hive.box(i);
    final keys = box1.keys.cast<String>().toList();
    for(var k in keys){
      final temp = box1.get(k);
      fib += temp['fibre']*temp['quantity']*temp['quantityFactor']/100 ;
    }
  }
  return fib;
}

double totalFats(){
  double fat = 0;
  List<String> x = ['breakfast','lunch','dinner','snacks'];
  for(var i in x){
    final box1 = Hive.box(i);
    final keys = box1.keys.cast<String>().toList();
    for(var k in keys){
      final temp = box1.get(k);
      fat += temp['fats']*temp['quantity']*temp['quantityFactor']/100 ;
    }
  }
  return fat;
}

double totalCarbs(){
  double carb = 0;
  List<String> x = ['breakfast','lunch','dinner','snacks'];
  for(var i in x){
    final box1 = Hive.box(i);
    final keys = box1.keys.cast<String>().toList();
    for(var k in keys){
      final temp = box1.get(k);
      carb += temp['carbs']*temp['quantity']*temp['quantityFactor']/100 ;
    }
  }
  return carb;
}

int totalCaloriesFrom(String mealType) {
  double cal = 0;
  final box = Hive.box(mealType);
  final keys = box.keys.cast<String>().toList();
  for (var k in keys) {
    final temp = box.get(k);
    cal += temp['calories']*temp['quantity']*temp['quantityFactor']/100 ;
  }
  return cal.toInt();
}

double totalProteinFrom(String mealType) {
  double pro = 0;
  final box = Hive.box(mealType);
  final keys = box.keys.cast<String>().toList();
  for (var k in keys) {
    final temp = box.get(k);
    pro += temp['protein']*temp['quantity']*temp['quantityFactor']/100;
  }
  return pro;
}

double totalFibreFrom(String mealType) {
  double fib = 0;
  final box = Hive.box(mealType);
  final keys = box.keys.cast<String>().toList();
  for (var k in keys) {
    final temp = box.get(k);
    fib += temp['fibre']*temp['quantity']*temp['quantityFactor']/100;
  }
  return fib;
}

double totalFatsFrom(String mealType) {
  double fat = 0;
  final box = Hive.box(mealType);
  final keys = box.keys.cast<String>().toList();
  for (var k in keys) {
    final temp = box.get(k);
    fat += temp['fats']*temp['quantity']*temp['quantityFactor']/100;
  }
  return fat;
}

double totalCarbsFrom(String mealType) {
  double carb = 0;
  final box = Hive.box(mealType);
  final keys = box.keys.cast<String>().toList();
  for (var k in keys) {
    final temp = box.get(k);
    carb += temp['carbs']*temp['quantity']*temp['quantityFactor']/100;
  }
  return carb;
}
