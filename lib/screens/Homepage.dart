

import 'package:fitspark/hive/loadmeals.dart';
import 'package:fitspark/objects/meals.dart';
import 'package:fitspark/providers/exerciseProvider.dart';
import 'package:fitspark/screens/chatbot.dart';
import 'package:fitspark/screens/todaysMeal.dart';
import 'package:fitspark/screens/walking.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:fitspark/widgets/HomePagewidgets.dart';
import 'package:fitspark/widgets/multiwidgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Meal> meall = [];
 // Meal meal1 = Meal(name: "Roti", calories: 100, protein: 4, carbs: 12, fats: 5, fibre: 5, qunatity: 6, qunatityUnit: "rotis",quantityfactor: 30);
  //Meal meal2 = Meal(name: "Curd", calories: 200, protein: 20, carbs: 4, fats: 12, fibre: 0, qunatity: 200, qunatityUnit: "grams",quantityfactor: 200);
  @override
  void initState() {
    
    super.initState();
    loadMeals();
    loadexercises();
  }


  @override
  Widget build(BuildContext context) {
  // meall.add(meal1);
  // meall.add(meal2);
  final box1 = Hive.box('breakfast');
  final box2 = Hive.box('lunch');
  final box3 = Hive.box('snacks');
  final box4 = Hive.box('dinner');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal[800],
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: height),
          margin: EdgeInsets.only(top: height*0.06),
          decoration: BoxDecoration(color: MyTheme().appbackground,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          width: width,
            child: Column(
              children: [
                SizedBox(height: height*0.05,),   
                Container(
                  width: width*0.9,
                  alignment: Alignment.centerLeft,
                  child: Row(children:[ 
                    logo(45, 18),
                    SizedBox(width: 15,),
                    Expanded(child: Text("SAHIL BISHNOI",style: TextStyle(fontFamily: MyTheme().font,fontSize: 16),)),
                    Icon(Icons.settings,size: 30,),
                    SizedBox(width: 5,)
                    ])),
                SizedBox(height: height*0.04,), 
                Container(
                  width: width*0.9,
                  child: Text("Today's Goals",style: TextStyle(fontFamily: MyTheme().font,fontWeight: FontWeight.bold,fontSize: 18),)), 
                  SizedBox(height: 30,),       
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TodayMealPage())),
                  child: ValueListenableBuilder(
                    valueListenable: box2.listenable(),
                    builder: (context, value, child) =>  ValueListenableBuilder(
                      valueListenable: box1.listenable(),
                      builder: (context, value, child) =>   TodayMeal(height, width)),
                  )),
                  SizedBox(height: 20,),
                  OtherOptions(),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Chatbot())),
                    child: AiOption(height, width)),
                  SizedBox(height: 20,),
                  GestureDetector(
                    
                    child: MealPlanAiOptions(height, width)),



                  SizedBox(height: height*0.2,),


                
              ],
            ),
        ),
      ),
    );
  }
}


Widget logo(double size,double siz){
  return Container(
    height: size,width: size,
    decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.teal[800]),
    child: Center(
      child: Text("S",style: TextStyle(fontFamily: MyTheme().font,fontSize: siz,color: Colors.white,fontWeight: FontWeight.bold),),
    ),
  );
}