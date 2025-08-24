import 'package:fitspark/objects/exerciseobj.dart';
import 'package:fitspark/providers/exerciseProvider.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class ExerciseCardPage extends StatefulWidget {
  String name;
   ExerciseCardPage({super.key,required this.name});

  @override
  State<ExerciseCardPage> createState() => _ExerciseCardPageState();
}

class _ExerciseCardPageState extends State<ExerciseCardPage> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('exercises');
    final mp = box.get(widget.name);
    Exercise exe = Exercise.fromJson(mp);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyTheme().appbackground,
      body: Consumer<ExerciseProvider>(
        builder: (context,value,child) {
          return Container(
            width: width,
            child: Column(
              children: [
                SizedBox(height: height*0.04,),
                Container(width: width*0.9,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios,size: 28,)),
                ),
                SizedBox(height: height*0.025,),
                exeCard(height, width, exe, context),
                SizedBox(height: 20,),
                exespa(height, width, exe,context),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () { addExe(exe);
                  Navigator.pop(context);
                  },
                  child: saveexe(height, width)),
                SizedBox(height: height*0.06,)
              ],
            ),
          );
        }
      ),
    );
  }
}


Widget exeCard(double height,double width,Exercise exe,BuildContext context){
  return Container(
    height:  height*0.25,width: width*0.9,
    
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
    child: Column(
      children: [
        SizedBox(height: 10,),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          height: height*0.13,width: width*0.86,
          clipBehavior: Clip.hardEdge,
          child: Image.asset("assets/photos/bicep.jpg",fit: BoxFit.cover,)),
         Container(
          width: width*0.9,
          padding: EdgeInsets.only(left: 12,top: 5),
          alignment: Alignment.centerLeft,
          child: Text(exe.name.toUpperCase(),style: TextStyle(fontFamily: MyTheme().font,fontSize: 16),)),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            Container(
              width: width*0.25,
              child: Text("Equipment",style: TextStyle(fontFamily: MyTheme().font),),
            ),
            Container(
              width: width*0.3,
              child: Text(exe.equipment),
            )
          ],
        ),
        Row(
          children: [
          //  SizedBox(width: 10,),
            //Quantity
          SizedBox(width: 10,),
            Container(
              width: width*0.25,
              child: Text("Target Area",style: TextStyle(fontFamily: MyTheme().font),),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: width*0.3,
              child: Text(exe.targetarea),
            )
          ],
        )
      ],
    ),
  );
}

Widget exespa(double height,double width,Exercise exe,BuildContext context){
  return Container(
    width: width*0.9,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        SizedBox(height: 10,),
        Container(
          width: width*0.9,
          child: Row(
            children: [
              SizedBox(width: 10,),
              Expanded(child: Text("Calories burned",style: TextStyle(fontFamily: MyTheme().font,fontSize: 15),)),
              SizedBox(width: 5,),
              Text(((exe.calories*exe.sets*exe.reps/10).toInt()).toString() + " kcal",style: TextStyle(fontFamily: MyTheme().font,fontSize: 15),),
              SizedBox(width: 19,)
            ],
          ),
        ),
        SizedBox(height: 4,),
        Container(width: width*0.85,color: Colors.black,height: 1,),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            Container(
              width: width*0.7,
              child: Text("Total Sets")),
            Container(
              height: 30,width: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color.fromRGBO(230, 230, 230, 1)),
              child: GestureDetector(
                onTap: () => exesheet(exe, height, width, context),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Expanded(child: Text(exe.sets.toString())),
                   // SizedBox(width: 10,),
                    Icon(Icons.keyboard_arrow_down),
                    SizedBox(width: 5,),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            SizedBox(width: 10,),
            Container(
              width: width*0.7,
              child: Text("Reps per Set")),
            Container(
              height: 30,width: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color.fromRGBO(230, 230, 230, 1)),
              child: GestureDetector(
                onTap: () => exesheet(exe, height, width, context),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Expanded(child: Text(exe.reps.toString())),
                    Icon(Icons.keyboard_arrow_down),
                    SizedBox(width: 5,)
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20,)
      ],
    ),
  );
}



void exesheet(Exercise exe,double height,double width,BuildContext context){
  FixedExtentScrollController _controller = FixedExtentScrollController();
  FixedExtentScrollController _controller2 = FixedExtentScrollController();
  showModalBottomSheet(
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
                  Text("Sets",style: TextStyle(fontFamily: MyTheme().font),),
                  SizedBox(width: width*0.25,),
                  Text("Repetitions",style: TextStyle(fontFamily: MyTheme().font))
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
                          childCount: 10,
                          
                          builder:(context,index) { 
                           return Container(
                            child: Center(
                              child: Text((index+1).toString(),style: TextStyle(fontFamily: MyTheme().font),),
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
                          childCount: 100,
                          
                          builder:(context,index) { 
                           return Container(
                            child: Center(
                              child: Text((index+1).toString(),style: TextStyle(fontFamily: MyTheme().font),),
                            ),
                          );}
                          
                          )),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    exe.sets  =_controller.selectedItem+1;
                    exe.reps  =_controller2.selectedItem+1;
                    context.read<ExerciseProvider>().updateExe();
                    Navigator.pop(context);
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

Widget saveexe(double height,double width){
  return Material(
    color: Colors.green,
    borderRadius: BorderRadius.circular(10),
    elevation: 2,
    child: Container(
      height: height*0.055,width: width*0.9,
      child: Center(
        child: Text("ADD EXERCISE",style: TextStyle(color: Colors.white,fontFamily: MyTheme().font),),
      ),
    ),
  );

}