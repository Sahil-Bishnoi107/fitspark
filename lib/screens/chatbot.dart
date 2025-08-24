import 'package:fitspark/providers/chatProvider.dart';
import 'package:fitspark/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:icons_plus/icons_plus.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController tc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('chats');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Container(
          width: width,height: height,
          child: Column(
            children: [
              Container(height: height*0.04,
              color: Colors.transparent,
              ),
             Container(height: height*0.04,
             decoration: BoxDecoration(color:MyTheme().appbackground,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
             ),
              ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) { 
                  final messages = box.get('chat');
        
              return Container(height: height*0.79, width: width,
              padding: EdgeInsets.symmetric(horizontal: width*0.03),
              color: MyTheme().appbackground,
                child: messages == null ? SizedBox.shrink()      :  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: messages.length,
                  itemBuilder: (context,index){
                    final message = messages[index];
                    
                    return Align(
                      alignment: message['me'] ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        
                        constraints: BoxConstraints(minWidth: 0,maxWidth: width*0.7),
                        
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            message['me'] ? SizedBox.shrink() :  boticon(),
                            SizedBox(width: 5,),
                            Flexible(child: Container(
                              padding: EdgeInsets.only(top: 8,left: 10,right: 10,bottom: 8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white ),
                              child: Text(message['message'],style: TextStyle(color: Colors.black ,fontFamily: MyTheme().font),))),
                          ],
                        ),
                      ));
                  }),
                );}
              ),
              searchh(height, width, tc),
              Container(height: height*0.067,color:MyTheme().appbackground,)
            ],
          ),
        
        ),
      ),
    );
  }
}


Widget boticon(){
  return Container(
          height: 30,width: 30,
          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 1,color: const Color.fromRGBO(197, 202, 233, 0.4))),
          child: Center(child: Icon(BoxIcons.bx_bot,size: 18,)),
        );
}


Widget searchh(double height,double width,TextEditingController tc,){
  return Container(
    color: MyTheme().appbackground,
    padding: EdgeInsets.only(top: 10),
    child: Row(
      children: [
        SizedBox(width: width*0.04,),
        Container(
          padding: EdgeInsets.only(left: 15),
          constraints: BoxConstraints(minHeight: height*0.04,maxHeight: height*0.5,maxWidth: width*0.8,minWidth: width*0.8),
          decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: tc,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Ask for Advice!",hintStyle: TextStyle(fontFamily: MyTheme().font,color: Colors.grey)),
            style: TextStyle(fontFamily: MyTheme().font),
          ),
        ),
        SizedBox(width: 7,),
        InkWell(
          onTap: () {
            
            savemessage(tc.text, true);
            callApi(tc.text);
            tc.text = "";
          },
          child: Container(
            height: 50,width: 50,
            decoration: BoxDecoration(shape: BoxShape.circle,color: MyTheme().appbackground,border: Border.all(color: Colors.black),),
          child: Center(child: Icon(Icons.send,color: Colors.black,)),
          ),
        )
      ],
    ),
  );
}

