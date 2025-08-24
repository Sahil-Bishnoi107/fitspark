import 'dart:async';

import 'package:fitspark/permissions.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pedometer/pedometer.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  late StreamSubscription<StepCount> _subscription;
  int steps = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
    _subscription = Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
    );
  }

  void _onStepCount(StepCount event) {
    if (!mounted) return;
    setState(() {
      steps = event.steps;
    });
  }

  void _onStepCountError(error) {
    print("Step Count Error: $error");
  }
  @override
  void dispose() {
    _subscription.cancel(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double walkdis = steps*0.7;
    double calburn = steps*0.04;
    double timewal = walkdis/90;
    return Scaffold(
      backgroundColor: MyTheme().appbackground,
      body:  Column(
        children: [
          SizedBox(height: height*0.05,),
         backButton(height, width, context),
        SizedBox(height: height*0.05,),
        Container(
          width: width,
          child: Center(child: ring(steps: steps,))),
          SizedBox(height: height*0.07,),
          Container(width: width*0.9,alignment: Alignment.centerLeft,child: Text("More Infromation",style: TextStyle(fontFamily: MyTheme().font,fontSize: 16),),),
          SizedBox(height: height*0.01,),
          stepOption(height, width, FontAwesome.person_walking_solid, "Walking Distance", "A healthy person needs to walk 5 km per day!", walkdis.toInt().toString()," m",const Color.fromRGBO(200, 230, 201, 0.4)),
          SizedBox(height: 10,),
          stepOption(height, width, FontAwesome.fire_solid, "Calories burnt", "Running is one of the best exercises to lose fat!", calburn.toInt().toString()," Cal",const Color.fromRGBO(255, 205, 210, 0.7)),
          SizedBox(height: 10,),
          stepOption(height, width,Icons.timer_outlined , "Time Walked", "Walikng 30 mins a day improves mood and refreshes your mind!", timewal.toInt().toString()," mins",const Color.fromRGBO(255, 205, 210, 0.7)),
          SizedBox(height: 10,),
          stepOption(height, width, FontAwesome.person_running_solid, "Avg Speed", "Humans can run upto 25km per hour. How much can you!", (5.2).toString()," Km/h",const Color.fromRGBO(255, 205, 210, 0.7))
        ],
      ),
    );
  }
}

Widget backButton(double height,double width,BuildContext context){
  return Container(
    width: width*0.9,
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.only(left: width*0.01),
                  width: width*0.1, height: height*0.05,
                  alignment: Alignment.centerLeft,child: Icon(Icons.arrow_back_ios),),
        ),
        Expanded(child: Center(child: Text("TODAY",style: TextStyle(fontFamily: MyTheme().font,fontSize: 20),))),
        SizedBox(width: width*0.1,)
      ],
    ),
  );
}

class ring extends StatefulWidget {
  int steps;
   ring({super.key,required this.steps});

  @override
  State<ring> createState() => _ringState();
}

class _ringState extends State<ring> {
 
 
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = 150;
    Color color1 = const Color.fromRGBO(102, 187, 106, 1);
    Color color2 = MyTheme().lightgrey;
    double percentage = widget.steps/10000;
    return Container(
      child: Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        height: size,width: size,
        child: CircularProgressIndicator(
          value: percentage,
          strokeWidth: 8,
          backgroundColor: color2,
          valueColor: AlwaysStoppedAnimation<Color>(color1),
        ),
      ),
      Container(
        height: size*0.9,width: size*0.9,
        padding: EdgeInsets.all(size*0.07),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          //color: Colors.white,
          
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(widget.steps.toString(),style: TextStyle(fontFamily: MyTheme().font,fontSize: 25),),
            Text("Steps",style: TextStyle(fontFamily: MyTheme().font,fontSize: 20),)
          ],
        )
      )
    ],
  )
    );
  }
}


Widget stepOption(double height,double width,IconData i,String name,String des,String num,String sub,Color color){
  return Container(
    height: height*0.1,width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
    child: Row(
      children: [
        SizedBox(width: width*0.03,),
        Container(
          height: 50,width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 2,color: color)),
          child: Icon(i)),
        SizedBox(width: width*0.03,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.018,),
              Text(name,style: TextStyle(fontFamily: MyTheme().font,fontSize: 15),),
              Text(des,style: TextStyle(fontFamily: MyTheme().font,color: Colors.blueGrey,fontSize: 10),)
            ],
          ),
          
        ),
        SizedBox(width: 30,),
       Text(num+ sub ,style: TextStyle(fontFamily: MyTheme().font,fontSize: 20),),
       SizedBox(width: 30,)
      ],
    ),
  );
}