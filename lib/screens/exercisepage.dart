import 'package:fitspark/providers/exerciseProvider.dart';
import 'package:fitspark/screens/addexercise.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:fitspark/widgets/smallWidgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:icons_plus/icons_plus.dart';

class exercisePage extends StatefulWidget {
  const exercisePage({super.key});

  @override
  State<exercisePage> createState() => _exercisePageState();
}

class _exercisePageState extends State<exercisePage> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('todayexe');
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyTheme().appbackground,
      body: SingleChildScrollView(
        child: Container(
          height: height,width: width,
          child: Column(
            children: [
              SizedBox(height: height*0.03,),
                 GestureDetector(
                  onTap: () => Navigator.pop(context),
                   child: Container(
                    alignment: Alignment.centerLeft,
                    height: height*0.06,width: width*0.86,
                    child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 30,),
                   ),
                 ),
                 SizedBox(height: height*0.03,),
                 ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    final cals = totalcals();
                    final mins = totalmins();
                    return topbar(height, width, cals, mins,(cals/2.5).toInt());
                  }, ),
                 SizedBox(height: 30,),
                 Container(width: width*0.9,
                 child: Text("Exercises",style: TextStyle(fontFamily: MyTheme().font,fontSize: 16),),
                 ),
                 SizedBox(height: 10,),
                 ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    final keys = box.keys.cast<String>().toList();
                  return  ourlist(height, width, keys, box);
                  }  ),
                  SizedBox(height: 10,),
                  addexercise(height, width,context)
            ],
          ),
        )
        )
      );
  }
}

Widget topbar(double height,double width,int cal,int b,int percentage,){
  return Container(
    height: height*0.12,width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        SizedBox(width: 20,),
        ourProgressIndicator2(percentage.toDouble(), Colors.orange, MyTheme().lightgrey, 75, ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              Text("Exercise Plan",style: TextStyle(fontFamily: MyTheme().font,fontSize: 22),),
              Text("Ideal time: " + b.toString() + " mins",style: TextStyle(fontFamily: MyTheme().font,fontSize: 12,color: Colors.blueGrey),)
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: 25,),
            Text(cal.toString(),style: TextStyle(fontFamily: MyTheme().font,fontSize: 23)),
            Text(" Cal",style: TextStyle(fontFamily: MyTheme().font,fontSize: 18))
          ],
        ),
        SizedBox(width: 25)
      ],
    ),
  );
}

Widget ourlist(double height,double width,List<String> keys,Box<dynamic> box){
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    
    padding: EdgeInsets.symmetric(horizontal: width*0.05),
    physics: NeverScrollableScrollPhysics(),
    itemCount: keys.length,
    itemBuilder: (context,index){
      final key = keys[index];
      final exe = box.get(key);
      return exetile(height, width,50,exe['name'],exe['calories'].toString(),exe['sets'],exe['reps']);
    }
    );
}

Widget exetile(double height,double width,double size,String name,String cal,int sets,int reps){
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    height: height*0.07,width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 10,),
        Container(
          height: size,width: size,
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all()),
          child: Icon(FontAwesome.person_running_solid,size: size*0.45,),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name.toUpperCase(),style: TextStyle(fontFamily: MyTheme().font,fontSize: 15),),
              Text("Calories burnt " + cal,style: TextStyle(fontFamily: MyTheme().font,fontSize: 12),)
            ],
          ),
        ),
        Text(sets.toString() + '\u00D7' + reps.toString(),style: TextStyle(fontFamily: MyTheme().font,fontSize: 16),),
        SizedBox(width: 20,)
      ],
    ),
  );
}

Widget addexercise(double height,double width,BuildContext context){
  return GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => searchexe())),
    child: Container(
      height: height*0.05,width: width*0.9,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Icon(Icons.add,color: Colors.blue,),
         // SizedBox(width: 15,),
          Expanded(child: Center(child: Text("ADD EXERCISE",style: TextStyle(fontFamily: MyTheme().font,color: Colors.blue),))),
          SizedBox(width: 40,)
        ],
      ),
    ),
  );
}