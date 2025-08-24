import 'package:fitspark/providers/exerciseProvider.dart';
import 'package:fitspark/screens/exercisecard.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class searchexe extends StatefulWidget {
  const searchexe({super.key});

  @override
  State<searchexe> createState() => _searchexeState();
}

class _searchexeState extends State<searchexe> {
  TextEditingController txt = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txt.addListener(updatelist);
    context.read<ExerciseProvider>().initalizeExe();
  }
  void updatelist(){
    context.read<ExerciseProvider>().searchResults(txt.text);
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: height,width: width,
        padding: EdgeInsets.only(left: width*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.04,),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Align(alignment: Alignment.centerLeft, child: Icon(Icons.arrow_back_ios,size: 30,),)),
           SizedBox(height: height*0.02,),
           SearchBar(height, width, txt),
           SizedBox(height: 30,),
           Text("Exercises",style: TextStyle(fontFamily: MyTheme().font,fontSize: 15),),
           Consumer<ExerciseProvider>(
            builder: (context,value,child){
              List<String> ourexe = value.exerciseList;
              return Container(
                height: height*0.8,width: width*0.9,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: 10),
                  itemCount: ourexe.length,
                  itemBuilder: (context,index){
                    final name = ourexe[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExerciseCardPage(name: name))),
                      child: exetile(height, width, name));
                  }),
              );
            })
          ],
        ),
      ),
    );
  }
}


Widget SearchBar(double height,double width,TextEditingController txt ){ 
  return Container(
   height: height*0.05,width: width*0.9,
   padding: EdgeInsets.only(left: 15),
   decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
   child: Row(
     children: [
       Expanded(
         child: TextField(
          controller: txt,
          maxLines: null,
          decoration: InputDecoration(border: InputBorder.none,hintText: "Search Exercises!", hintStyle: TextStyle(color: Colors.grey,fontFamily: MyTheme().font)),
         ),
       ),
       Icon(Icons.search,size: 28,),
       SizedBox(width: 12,)
     ],
   ),
  );
}

Widget exetile(double height,double width,String name){
  return Container(
    width: width*0.9,height: height*0.04,
    child: Row(
      children: [
          Expanded(child: Text(name.toUpperCase(),style: TextStyle(fontFamily: MyTheme().font,fontSize: 15),)),
          Icon(Icons.arrow_forward_ios),
          SizedBox(width: 20,)
      ],
    ),
  );
}