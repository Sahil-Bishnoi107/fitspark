import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitspark/objects/exerciseobj.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExerciseProvider extends ChangeNotifier{
   List<String> exerciseList = [];
   final box = Hive.box('exercises');


   void searchResults(String text){
    if(text == ""){exerciseList = box.keys.cast<String>().toList();notifyListeners();return;}
    List<String> temp = [];
    temp = searchOptions2(text);
    exerciseList = temp;
    notifyListeners();
    
   
   }

   void updateExe(){
    notifyListeners();
   }

   void initalizeExe(){
    exerciseList = box.keys.cast<String>().toList();
    //notifyListeners();
   }
}



void loadexercises() async{
  final box = Hive.box('exercises');
  final a = await FirebaseFirestore.instance.collection('exercises').get();
  for(var doc in a.docs){
    final temp = doc.data();
    final d = {"name": temp['name'] , "calories" : temp["calories"], "sets" : 1,"time" : temp['time'],"reps" : 10,"equipment":temp['equipment'], "targetarea":temp['targetarea']};
     box.put(temp['name'],d);
  }
 
}


List<String> searchOptions2(String text){
  List<String> temp = [];
  final box = Hive.box('exercises');
  final keys = box.keys.cast<String>().toList();
  for(var x in keys){
    if(x.toLowerCase().contains(text.toLowerCase())){temp.add(x);}
  }
  return temp;
}

void addExe(Exercise exe){
  final box = Hive.box('todayexe');
  final d = {"name": exe.name , "calories" : exe.calories, "sets" : exe.sets,"time" : exe.time,"reps" : exe.reps,"equipment":exe.equipment, "targetarea":exe.targetarea};
  box.put(exe.name,d);
}

int totalcals(){
  final box = Hive.box('todayexe');
  final keys = box.keys;
  double ans = 0;
  for(var k in keys){
    final exe = box.get(k);
    ans = ans + exe['calories'];
  }
  return ans.toInt();
}

int totalmins(){
  final box = Hive.box('todayexe');
  final keys = box.keys;
  double ans = 0;
  for(var k in keys){
    final exe = box.get(k);
    ans = ans + exe['time']*exe['sets']*exe['reps']/10;
    ans = ans + 30*(exe['sets'] - 1);
  }
  return (ans/60).toInt();
}