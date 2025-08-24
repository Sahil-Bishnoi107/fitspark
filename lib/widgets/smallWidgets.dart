import 'package:fitspark/hive/todaymeals.dart';
import 'package:fitspark/objects/meals.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Nutrient(String name, int num,int den,double height,double width,Color labelcolor){
  int percentage = den == 0 ? 0 :  (num*100/den).toInt();
  return Container(
    alignment: Alignment.centerLeft,
    color: Colors.white,
    height: height*0.04,width: width*0.4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(name  + ": ",style: TextStyle(color: MyTheme().appgrey,fontFamily: MyTheme().font,fontWeight: FontWeight.bold),),
            Text((percentage).toString() + "%",style: TextStyle(color: MyTheme().appgrey,fontFamily: MyTheme().font,fontWeight: FontWeight.bold))
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 5,width: width*0.33,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 228, 227, 227),borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 5,width: width*0.33*percentage/100,
            decoration: BoxDecoration(color: labelcolor,borderRadius: BorderRadius.circular(10)),
          ),
        )
      ],
    ),
  );
}

Widget mealtile(double height,double width,Meal meal,String mealtime,BuildContext context){
  return Container(
    padding: EdgeInsets.symmetric(vertical: height*0.009),
    child: Row(
      children: [
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(meal.name,style: TextStyle(color: Colors.black,fontFamily: MyTheme().font),),
              Text(meal.quantity.toString() + " " + meal.quantityUnit.toString(), style: TextStyle(color: MyTheme().darkgrey,fontFamily: MyTheme().font,fontSize: 10),)
            ],
          ),
        ),
         Text((meal.calories*meal.quantity*meal.quantityFactor/100).toString() + " Cal",style: TextStyle(color: MyTheme().darkgrey,fontSize: 15,fontFamily: MyTheme().font,fontWeight: FontWeight.w500),),
         SizedBox(width: 10,),
         GestureDetector(
          onTapDown: (details) => showOptions(details, height, width, mealtime, meal.name, context),
          child: Icon(Icons.more_vert,color: MyTheme().darkgrey,)),
          SizedBox(width: 10,),
      ],
    ),
  );
}

Widget addMeal(double height, double width,Meal meal){
  int totalcal = (meal.calories*meal.quantityFactor*meal.quantity/100).toInt();
  return Container(
    height: height*0.065,width: width*0.9,
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 5,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(meal.name.toUpperCase(), style: TextStyle(fontFamily: MyTheme().font),),
              Text((meal.quantity*meal.quantityFactor).toString() + " " + meal.quantityUnit,style: TextStyle(color: Colors.grey,fontFamily: MyTheme().font),)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Text(totalcal.toString() + " Cal",style: TextStyle(fontFamily: MyTheme().font,color: Colors.grey),),
              SizedBox(width: 10,),
          Container(
            height: 20,width: 20,
            decoration: BoxDecoration(border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(4)),
            child: Icon(Icons.add,size: 15,color: Colors.green,),
          ),
            ],
          ),
        ),
        
        SizedBox(width: 10,)
      ],
    ),
  );
}

Widget mealSuggestionTile(double height,double width,String mealname){
    return Container(
      height: height*0.04,width: width*0.9,
      child: Row(
        children: [
          Expanded(child: Text(mealname,style: TextStyle(color: Colors.black,fontFamily: MyTheme().font),)),
          Icon(Icons.arrow_forward_ios,color: Colors.black,),
          SizedBox(width: 10,)
        ],
      ),
    );
}

Widget Macro(String name,double numb,double height,double width,String svg){
  return Container(
    height: height*0.04,width: width*0.84,
    child: Row(
      children: [
        SizedBox(width: 10,),
        Transform.rotate(
          angle: svg == "assets/svgs/bean-svgrepo-com.svg" ? -0.8 : 0,
          child: Container(height: 20,width: 20,child: SvgPicture.asset(svg),)),
        SizedBox(width: 10,),
        Expanded(child: Text(name,style: TextStyle(color: Colors.black,fontFamily: MyTheme().font,fontSize: 15),)),
        Text("$numb g",style: TextStyle(color: Colors.black,fontFamily: MyTheme().font,fontSize: 15),),
        SizedBox(width: 10,)
      ],
    ),
  );
}

void showOptions(TapDownDetails details, double height,double width,String mealtime,String mealname,BuildContext context){
  final position = details.globalPosition;
  showMenu(
   context: context,
   shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10)
   ),
   color: Colors.white,
   position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
   items: [
   PopupMenuItem(
    value: "delete",
    child: Container(
          child: Center(
            child: Text("DELETE",style: TextStyle(fontFamily: MyTheme().font),),
          ),
    )),
   ]).then((value){
    if(value == "delete"){deleteMeal(mealtime, mealname);}
   });
}

Widget ourProgressIndicator(double percentage,Color color1,Color color2,double size,String path){
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        height: size,width: size,
        child: CircularProgressIndicator(
          value: percentage/100,
          strokeWidth: 3,
          backgroundColor: color2,
          valueColor: AlwaysStoppedAnimation<Color>(color1),
        ),
      ),
      Container(
        height: size*0.75,width: size*0.75,
        padding: EdgeInsets.all(size*0.1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          
        ),
        child: SvgPicture.asset(path,color: Colors.grey[700],),
      )
    ],
  );
}

Widget myicon(double height,double width,double size,IconData icon,double iconsize,Color color,String name){
  return Column(
    children: [
      Container(
        height: size,width: size,
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 2,color: color)),
        child: Icon(icon,size: iconsize,),
      ),
      SizedBox(height: 5,),
      Text(name,style: TextStyle(fontFamily: MyTheme().font,fontSize: 10),)
    ],
  );
}

Widget myicon2(double height,double width,double size,IconData icon,double iconsize,Color color,String name,String des){
  return Row(
    children: [
      SizedBox(width: 20,),
     Container(
      
      height: size,width: size,
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 2,color: color)),
      child: Icon(icon,size: iconsize,),
    ),
    SizedBox(width: 10,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,style: TextStyle(fontFamily: MyTheme().font),),
        Text(des,style: TextStyle(fontFamily: MyTheme().font,color: Colors.grey),)
      ],
    )
    ],
  );
}

Widget ourProgressIndicator2(double percentage,Color color1,Color color2,double size){
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        height: size,width: size,
        child: CircularProgressIndicator(
          value: percentage/100,
          strokeWidth: 6,
          backgroundColor: color2,
          valueColor: AlwaysStoppedAnimation<Color>(color1),
        ),
      ),
      Container(
        height: size*0.7,width: size*0.7,
       // padding: EdgeInsets.all(size*0.1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          
        ),
        child: Center(child: Text(percentage.toInt().toString() + "%",style: TextStyle(fontFamily: MyTheme().font),),),
      )
    ],
  );
}