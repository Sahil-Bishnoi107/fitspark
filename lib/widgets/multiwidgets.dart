
import 'package:fitspark/hive/calculations.dart';
import 'package:fitspark/hive/todaymeals.dart';
import 'package:fitspark/objects/meals.dart';
import 'package:fitspark/providers/searchprovider.dart';
import 'package:fitspark/screens/todaysMeal.dart';
import 'package:fitspark/widgets/intermediateWidgets.dart';
import 'package:fitspark/widgets/smallWidgets.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget TodayMeal(double height,double width){
  final per = totalCalories()/20;
  return Container(
    //alignment: Alignment.center,
    padding: EdgeInsets.only(left: 8,top: 10),
    height: height*0.215,width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: [
        SizedBox(height: height*0.018,),
        //layer 1
        Row(
          children: [
            SizedBox(width: width*0.04,),
            ourProgressIndicator(per, Colors.green, Colors.grey.withOpacity(0.5), 56, "assets/svgs/food-restaurant-svgrepo-com.svg"),
            SizedBox(width: width*0.05,),
            Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's Meals",style: TextStyle(color: Colors.black,fontFamily: MyTheme().font,fontWeight: FontWeight.bold,fontSize: 15),),
                Text("Eat 2000 Cal",style: TextStyle(color: MyTheme().appgrey,fontFamily: MyTheme().font,fontWeight: FontWeight.bold,fontSize: 12),)
              ],
            ))
          ],
        ),
        SizedBox(height: height*0.025,),
        //layer 2
        Row(
          children: [
            SizedBox(width: width*0.04,),
            Nutrient("Protein", totalProtein().toInt(), 85, height, width, MyTheme().percentagegreen),
            SizedBox(width: width*0.04,),
            Nutrient("Carbs", totalCarbs().toInt(), 250, height, width, MyTheme().percentagegreen)
          ],
        ),
        SizedBox(height: height*0.01,),
        //layer 3
        Row(
          children: [
            SizedBox(width: width*0.04,),
            Nutrient("Fat", totalFats().toInt(), 70, height, width, MyTheme().percentagegreen),
            SizedBox(width: width*0.04,),
            Nutrient("Fibre", totalFibre().toInt(), 30, height, width, MyTheme().percentagegreen)
          ],
        ),
      ],
    ),
  );
}

class MealList extends StatefulWidget {
  String title;
  int num;
  int den;

  MealList({super.key,required this.title,required this.num, required this.den});

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box(widget.title.toLowerCase());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(

      valueListenable: box.listenable(),
      builder: (context, value, child) {
        List<Meal> meallist = getMeals(widget.title.toLowerCase());
         return Container(
        width: width*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height*0.05,width: width*0.9,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Expanded(child: Text(widget.title,style:TextStyle(color: Colors.black,fontSize: 17,fontFamily: MyTheme().font),)),
                  Text(widget.num.toString() + " of " + widget.den.toString() + " Cal"),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(mealtime: widget.title))),
                    child: Container(
                      height: 25,width: 25,
                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
                      child: Icon(Icons.add,color: Colors.white,size: 20,)),
                  ),
                    SizedBox(width: 10,)
                ],
              ),
              
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final meal = meallist[index];
                return mealtile(height, width, meal,widget.title.toLowerCase(),context);
              }, 
              separatorBuilder: (context,index) => SizedBox(height: 5,), 
              itemCount: meallist.length),
            ),
      
      
          ],
        ),
      );}
    );
  }
}


Widget TodayMealStats(double height,double width,int num,int den){
  return Container(
    height: height*0.09,width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        SizedBox(width: 10,),
        Container(
          padding: EdgeInsets.all(10),
          height: 50,width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 3)),
          child: SvgPicture.asset('assets/svgs/food-restaurant-svgrepo-com.svg'),
        ),
        SizedBox(width: 10,),
        Expanded(child: Text("$num of $den Cal",style: TextStyle(fontFamily: MyTheme().font,color: Colors.black,fontSize: 15),)),
        Container(
          height: 35,width: 35,
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.green)),
          child: Icon(Icons.bar_chart_outlined,color: Colors.green,size: 20,)),
          SizedBox(width: 15,)
      ],
    ),
  );
}



//Search widget
class SearchMeal extends StatefulWidget {
  String mealtime;
  SearchMeal({super.key,required this.mealtime});

  @override
  State<SearchMeal> createState() => _SearchMealState();
}

class _SearchMealState extends State<SearchMeal> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    search.addListener(filter);
  }
  void filter(){
    String txt = search.text;
    context.read<SearchProvider>().searchMeals(txt);
  }
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(color: Colors.white,
    width: width,
    //width: width*0.9,
      child: Column(
        
        children: [
          SizedBox(height: 10,),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: height*0.05,maxHeight: height*0.05,maxWidth: width*0.9),
            child: Container(
              padding: EdgeInsets.only(left: 15),
              width: width*0.9,
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                  hintText: "Search food here!", hintStyle: TextStyle(fontFamily: MyTheme().font,color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontFamily: MyTheme().font),
              ),
            ),
          ),
      
          SizedBox(height: 10,),
          Consumer<SearchProvider>(
            builder: (context, value, child) {

              return value.suggestedMeals.isEmpty ? suggestions(height, width,context,widget.mealtime) : SearchResults(height,width,widget.mealtime);
            },
            )
        ],
      ),
    );
  }
}

class FoodCard extends StatefulWidget {
  String mealname;
  String mealtime;
   FoodCard({super.key,required this.mealname,required this.mealtime});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final box = Hive.box('meals');
    final temp = box.get(widget.mealname) as Map<String,dynamic>;
    final meal = Meal.fromJson(temp);
    return Container(width: width*0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height*0.02,),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: width*0.9,
              alignment: Alignment.centerLeft,
              child: Icon(Icons.arrow_back_ios,size: 30,),),
          ),
          SizedBox(height: height*0.03,),
          Consumer<SearchProvider>(builder: (context, value, child) =>  foodCard(height, width, meal,context)),
          SizedBox(height: 25,),
          Text("Macronutrients Breakdown",style: TextStyle(fontFamily: MyTheme().font,fontSize: 16),),
          SizedBox(height: 5,),
          Consumer<SearchProvider>(builder: (context, value, child) { return MacroNutrients(height, width, meal);}),
          SizedBox(height: height*0.15,),
          GestureDetector(
            onTap: () {
              addMealto(widget.mealtime, meal);
              Navigator.pop(context);
            },
            child: Material(
                elevation: 2,
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                child: Container(height: height*0.05,width: width*0.9,
                child: Center(child: Text("ADD",style: TextStyle(fontFamily: MyTheme().font,color: Colors.white),)),
                ),
              ),
          ),
        ],
      ),
    );
  }
}