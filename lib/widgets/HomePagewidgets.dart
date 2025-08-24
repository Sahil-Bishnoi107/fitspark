import 'package:fitspark/providers/searchprovider.dart';
import 'package:fitspark/screens/exercisepage.dart';
import 'package:fitspark/screens/walking.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:fitspark/widgets/smallWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class OtherOptions extends StatefulWidget {
  const OtherOptions({super.key});

  @override
  State<OtherOptions> createState() => _OtherOptionsState();
}

class _OtherOptionsState extends State<OtherOptions> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(minHeight: height*0.15,maxWidth: width*0.9,minWidth: width*0.9,maxHeight: height*0.45),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
      child: Consumer<SearchProvider>(
        builder: (context, value, child) => value.openoptions ? Options1(height, width,context) : Options2(height,width,context)) ,
    );
  }
}


Widget Options1(double height,double width,BuildContext context){
  return Container(
    width: width*0.9,height: height*0.11,
    padding: EdgeInsets.only(top: height*0.025),
    child: Column(
      children: [
        SizedBox(
          width: width*0.86,height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(0),
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => exercisePage())),
                child: myicon(height, width, 50, FontAwesome.fire_solid, 18,const Color.fromRGBO(248, 187, 208, 0.4),"Workout")),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Steps())),
                child: myicon(height, width, 50, FontAwesome.person_walking_solid, 18,const Color.fromRGBO(225, 190, 231, 0.4),"Steps")),
              myicon(height, width, 50, FontAwesome.moon, 18,const Color.fromRGBO(187, 222, 251, 0.4),"Sleep"),
              myicon(height, width, 50, FontAwesome.weight_hanging_solid, 16,const Color.fromRGBO(178, 223, 219, 0.4),"weight"),
              myicon(height, width, 50, FontAwesome.glass_water_solid, 18,const Color.fromRGBO(200, 230, 201, 0.4),"Water"),
              //myicon(height, width, 50, FontAwesome.person_walking_solid, 20,const Color.fromRGBO(207, 216, 220, 0.4),"Steps")
            ],
          ),
        ),
       // SizedBox(height: 10,),
        InkWell(
          onTap: () => context.read<SearchProvider>().toogleopen(),
          child: Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            width: width*0.9,height: 40,
            child: Icon(Icons.keyboard_arrow_down_sharp),
          ),
        )
      ],
    ),
  );
}

Widget Options2(double height,double width,BuildContext context){
  return Column(
    children: [
      SizedBox(height: height*0.012,),
      myicon2(height, width, 50, FontAwesome.fire_solid, 18,const Color.fromRGBO(248, 187, 208, 0.4),"Workout","Target Calories to burn 200"),
      GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Steps())),
        child: myicon2(height, width, 50, FontAwesome.person_walking_solid, 18,const Color.fromRGBO(225, 190, 231, 0.4),"Steps","Walk 10,000 Steps Today")),
      myicon2(height, width, 50, FontAwesome.moon, 18,const Color.fromRGBO(187, 222, 251, 0.4),"Sleep","Sleep for 8 hours"),
      myicon2(height, width, 50, FontAwesome.weight_hanging_solid, 16,const Color.fromRGBO(178, 223, 219, 0.4),"Sleep","Your Ideal Weight is 70"),
      myicon2(height, width, 50, FontAwesome.glass_water_solid, 18,const Color.fromRGBO(200, 230, 201, 0.4),"Water","Drink 2 Litres of water"),
     //  SizedBox(height: 10,),
        InkWell(
           onTap: () => context.read<SearchProvider>().toogleopen(),
          child: Container(
            padding: EdgeInsets.only(top: 10),
            width: width*0.9,height: 50,
            child: Icon(Icons.keyboard_arrow_up),
          ),
        )
    ],
  );
}


Widget AiOption(double height,double width){
  return Container(
    height: height*0.12,width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
    child: Row(
      children: [
        SizedBox(width: 20,),
        Container(
          height: 70,width: 70,
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 3,color: const Color.fromRGBO(197, 202, 233, 0.4))),
          child: Center(child: Icon(BoxIcons.bx_bot,size: 30,)),
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Spark Bot",style: TextStyle(fontFamily: MyTheme().font,fontSize: 18),),
            Container(
              width: width*0.53,
              child: Text("I am here to help you with your doubts about your health and well being. Feel free to ask me anything!",style: TextStyle(fontFamily: MyTheme().font,fontSize: 10,color: Colors.blueGrey),))
          ],
        ),
        SizedBox(width: 15,),
        Icon(Icons.arrow_forward_ios_rounded)
      ],
    ),
  );
}



Widget MealPlanAiOptions(double height,double width){
  return Container(
    height: height*0.12,width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
    child: Row(
      children: [
        SizedBox(width: 20,),
        Container(
          height: 70,width: 70,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 3,color: const Color.fromRGBO(215, 204, 200, 0.4))),
          child: Center(child: SvgPicture.asset("assets/svgs/food-bag-svgrepo-com.svg")),
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Meal Plan",style: TextStyle(fontFamily: MyTheme().font,fontSize: 18),),
            Container(
              width: width*0.53,
              child: Text("Not sure what to eat to get your desired weight, worry not this Ai bot will help you plan your ideal meal plan for the day!",style: TextStyle(fontFamily: MyTheme().font,fontSize: 10,color: Colors.blueGrey),))
          ],
        ),
        SizedBox(width: 15,),
        Icon(Icons.arrow_forward_ios_rounded)
      ],
    ),
  );
}