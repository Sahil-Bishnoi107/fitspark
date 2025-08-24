import 'package:fitspark/hive/loadmeals.dart';
import 'package:fitspark/objects/meals.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{
  List<String> suggestedMeals = [];
  void searchMeals(String text){
    if(text.trim().isEmpty){suggestedMeals = [];notifyListeners(); return;}
    List<String> temp = [];
    temp = searchOptions(text);
    suggestedMeals = temp;
    notifyListeners();
  }
  void updatechanges(){
    notifyListeners();
  }
  bool openoptions = true;
  void toogleopen(){
    openoptions = !openoptions;
    notifyListeners();
  }
}