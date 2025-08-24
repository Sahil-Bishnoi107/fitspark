import 'package:fitspark/hive/calculations.dart';
import 'package:fitspark/hive/todaymeals.dart';
import 'package:fitspark/providers/searchprovider.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:fitspark/widgets/multiwidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayMealPage extends StatefulWidget {
  const TodayMealPage({super.key});

  @override
  State<TodayMealPage> createState() => _TodayMealPageState();
}

class _TodayMealPageState extends State<TodayMealPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyTheme().appbackground,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Column(
            children: [
              SizedBox(height: height*0.04,),
              Container(
                width: width*0.9,alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios,size: 30,)),
              ),
              SizedBox(height: height*0.03,),
              TodayMealStats(height, width, totalCalories(), 2000),
              SizedBox(height: height*0.04,),
              MealList(title: "Breakfast", num: totalCaloriesFrom("breakfast"), den: 500,),
              MealList(title: "Lunch", num: totalCaloriesFrom("lunch"), den: 500,),
              MealList(title: "Snacks", num: totalCaloriesFrom("snacks"), den: 500,),
              MealList(title: "Dinner", num: totalCaloriesFrom("dinner"), den: 500,),
              SizedBox(height: 100,)
              
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  String mealtime;
   SearchPage({super.key,required this.mealtime});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Column(
            children: [
              SizedBox(height: height*0.05,),
              SearchMeal(mealtime: widget.mealtime,)
            ],
          ),
        ),
      ),
    );
  }
}


class FoodPage extends StatefulWidget {
  String mealname;
  String mealtime;
   FoodPage({super.key,required this.mealname,required this.mealtime});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme().appbackground,
      body: Container(
         
         width: width,
         child: Column(
           children: [
             SizedBox(height: height*0.02,),
             Expanded(child: FoodCard(mealname: widget.mealname,mealtime: widget.mealtime,)),
             
            // SizedBox(height: 70,)
           ],
         ),
       ),
    );
  }
}