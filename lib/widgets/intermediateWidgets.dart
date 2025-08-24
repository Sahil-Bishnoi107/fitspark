import 'package:fitspark/objects/meals.dart';
import 'package:fitspark/providers/searchprovider.dart';
import 'package:fitspark/screens/todaysMeal.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:fitspark/widgets/multiwidgets.dart';
import 'package:fitspark/widgets/smallWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

Widget suggestions(double height,double width,BuildContext context,String mealtime){
  final box = Hive.box('meals');
  List<Meal> suglist = [];
  final keys = box.keys.cast<String>().toList();
  int lim = keys.length >= 15 ? 15 : keys.length;
  for(int i = 0; i< lim;i++){
    final key = keys[i];
    final map = box.get(key);
    suglist.add(Meal.fromJson(Map<String, dynamic>.from(map)));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: height*0.03,),
      Container(
        margin: EdgeInsets.only(left: width*0.06),
        child: Text("Most Frequently Tracked Foods:",style: TextStyle(color: Colors.blueGrey),)),
      ListView.separated(
        padding: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.015,bottom: height*0.1),
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (contxet,index){
          final meal = suglist[index];
          meal.quantity = 100;
          return InkWell(
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (_) => FoodPage(mealname: meal.name, mealtime: mealtime)));
            },
            child: addMeal(height, width, meal));
        }, 
        separatorBuilder: (context,index) => SizedBox(height: 0,), 
        itemCount: suglist.length),
    ],
  );
}

Widget SearchResults(double height,double width,String mealtime){
  return Consumer<SearchProvider>(builder: (context,value,_){
    List<String> meals = value.suggestedMeals;
    return Container(
      color: Colors.white,
      width: width*0.9,
      height: height*0.7,
      child: ListView.builder(
        scrollDirection: Axis.vertical, 
        itemCount: meals.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          final meal = meals[index];
          return GestureDetector(
            onTap: () { 
             // FocusScope.of(context).unfocus();
              Navigator.push(context, MaterialPageRoute(builder: (context) => FoodPage(mealname: meal,mealtime: mealtime,)));},
            child: mealSuggestionTile(height, width, meal));
        }),
    );
  });
}

Widget MacroNutrients(double height,double width,Meal meal){
  return Container(height: height*0.3,width: width*0.9,
  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
  child: Column(
    children: [
      SizedBox(height: 10,),
      Row(
        children: [
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               // SizedBox(width: 10,),
                Text("Calories",style: TextStyle(color: MyTheme().appgrey,fontFamily: MyTheme().font,fontSize: 18),),
                Text((roundUp(meal.calories*meal.quantity*meal.quantityFactor/100, 2)).toString() + "Cal",
                style: TextStyle(fontFamily: MyTheme().font,fontSize: 14),
                )
              ],
            ),
          ),
          Container(
            height: 30,width: width*0.25,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: MyTheme().p),
            child: Center(child: Text("Net wt: "  + (meal.quantity*meal.quantityFactor).toString() + " g",style: TextStyle(fontFamily: MyTheme().font,fontSize: 10),),),
          ),
          SizedBox(width: 20,)
        ],
      ),
      SizedBox(height: 8,),
      Container(height: 1,width: width*0.8,color: Colors.grey,),
      SizedBox(height: 20,),
      Macro("Proteins", roundUp(meal.protein*meal.quantityFactor*meal.quantity/100, 2), height, width, MyTheme().bean),
      Macro("Fats", roundUp(meal.fats*meal.quantityFactor*meal.quantity/100, 2), height, width, MyTheme().oil),
      Macro("Carbs", roundUp(meal.carbs*meal.quantityFactor*meal.quantity/100, 2), height, width, MyTheme().bean),
      Macro("Fibre", roundUp(meal.protein*meal.quantityFactor*meal.quantity/100, 2), height, width, MyTheme().fibre)
    ],
  ),
  );
}

Widget foodCard(double height,double width,Meal meal,BuildContext context){
  return Container(
    height:  height*0.28,width: width*0.9,
    
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
    child: Column(
      children: [
        SizedBox(height: 10,),
        Container(height: height*0.15,width: width*0.86,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        child: ClipRect(child: Image.asset("assets/photos/pexels-suzyhazelwood-1510392.jpg",fit: BoxFit.cover,)),
        ),
        SizedBox(height: 5,),
         Container(
          alignment: Alignment.centerLeft,
          width: width*0.84,
          child: Text(meal.name.toUpperCase(),style: TextStyle(fontFamily: MyTheme().font,fontSize: 20),)),
        SizedBox(height: 5,),
        Row(
          children: [
            SizedBox(width: 10,),
            Container(
              width: width*0.3,
              child: Text("Quantity",style: TextStyle(fontFamily: MyTheme().font),),
            ),
            Container(
              width: width*0.3,
              child: Text("Measure"),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(width: 10,),
            //Quantity
            GestureDetector(
              onTap: () {
                foodsheet(meal, height, width, context);
              },
              child: Container(
                height: height*0.035,width: width*0.2,
                decoration: BoxDecoration(color: MyTheme().p,borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Expanded(child: Text(meal.quantity.toString(),style: TextStyle(fontFamily: MyTheme().font),)),
                    Icon(Icons.keyboard_arrow_down,size: 15,),
                    SizedBox(width: 5,)
                  ],
                ),
              ),
            ),
            SizedBox(width: width*0.1,),
            //Measure
            GestureDetector(
              onTap : ()=> foodsheet(meal, height, width, context),
              child: Container(
                height: height*0.035,width: width*0.4,
                 decoration: BoxDecoration(color: MyTheme().p,borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Expanded(child: Text(meal.quantityUnit,style: TextStyle(fontFamily: MyTheme().font),)),
                    Icon(Icons.keyboard_arrow_down,size: 15,),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

void foodsheet(Meal meal,double height,double width,BuildContext context){
  FixedExtentScrollController _controller = FixedExtentScrollController();
  FixedExtentScrollController _controller2 = FixedExtentScrollController();
  List<String> quantityFactor = meal.type == "a" ?  ["grams","small piece","medium piece","large piece"] : ["grams","small bowl","medium bowl","big bowl"];;
   
  List<double> measuelist = [1,meal.small,meal.medium,meal.big];
  showBottomSheet(
    context: context,
    backgroundColor: Colors.white,
     builder: (context){
       return Stack(
         children: [
          Positioned(
            top: height*0.198,
            child: Container(height: 40,width: width,color: Colors.green.withOpacity(0.3),)),
           Container(
            height: height*0.52,width: width,
            padding: EdgeInsets.only(top: 0,bottom: 70,left: 20,right: 20),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(width: width*0.15,),
                  Text("Measure",style: TextStyle(fontFamily: MyTheme().font),),
                  SizedBox(width: width*0.25,),
                  Text("Quantity",style: TextStyle(fontFamily: MyTheme().font))
                  ],
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: height*0.35,width: width*0.4,
                      child: ListWheelScrollView.useDelegate(
                        controller: _controller,
                        itemExtent: 50, 
                      //  scrollBehavior: Axis.vertical,
                        physics: FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: quantityFactor.length,
                          
                          builder:(context,index) { 
                           return Container(
                            child: Center(
                              child: Text(quantityFactor[index],style: TextStyle(fontFamily: MyTheme().font),),
                            ),
                          );}
                          
                          )),
                    ),
                           
                
                
                     Container(
                      alignment: Alignment.topLeft,
                      height: height*0.35,width: width*0.4,
                      child: ListWheelScrollView.useDelegate(
                        controller: _controller2,
                        itemExtent: 50, 
                      //  scrollBehavior: Axis.vertical,
                        physics: FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 1000,
                          
                          builder:(context,index) { 
                           return Container(
                            child: Center(
                              child: Text((index).toString(),style: TextStyle(fontFamily: MyTheme().font),),
                            ),
                          );}
                          
                          )),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    meal.quantity = _controller2.selectedItem.toDouble();
                    meal.quantityUnit = quantityFactor[_controller.selectedItem];
                    meal.quantityFactor = measuelist[_controller.selectedItem];
                    print(meal.quantityUnit + meal.quantity.toString());
                    Navigator.pop(context);
                    context.read<SearchProvider>().updatechanges();
                  },
                  child: Material(
                    elevation: 2,
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                     height: 50,width: width*0.9,
                     child: Center(
                      child: Text("CONFIRM",style: TextStyle(color: Colors.white,fontFamily: MyTheme().font),),
                     ),
                    ),
                  ),
                )
              ],
            ),
           ),

           
         ],
       );
     });
}