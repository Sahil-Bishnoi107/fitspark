import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Chatprovider extends ChangeNotifier{
  
}

void savemessage(String message,bool fromme){
  final box = Hive.box('chats');
  List<Map<String,dynamic>> chats = [];
  
  if(box.containsKey('chat')){
   chats = (box.get('chat') as List)
    .map((e) => Map<String, dynamic>.from(e as Map))
    .toList();}
   Map<String,dynamic> m = {
    "message" : message, "me":fromme
   };
  chats.add(m);
  box.put('chat', chats);
}
void deletelastmessage(){
final box = Hive.box('chats');
  List<Map<String,dynamic>> chats = [];
  
  if(box.containsKey('chat')){
   chats = box.get('chat');}
   chats.removeLast();
   box.put('chat', chats);
}



void callApi(String message) async{
  final apiKey = 'AIzaSyBy-yM8QR7nXgculyasWHJgsaoq6dnk2rs';
  final endpoint =     'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent?key=$apiKey'
;
  final headers = ({
    'Content-Type' : 'application/json',
  });

  String prompt = '''  
   You are a health and fitness expert. I am sharing a message with you, you have to reply to it accordingly.
  $message
  Keep your answer short and like a reply from an actual doctor or person, use friendly and human like tone. feel free to use emojis if necessary
     ''';
    final body = jsonEncode({
    'contents': [
      {
        'parts': [
          {'text': prompt}
        ]
      }
    ]
  });

  try{
    final response = await http.post(Uri.parse(endpoint), headers: headers,body: body);
    if(response.statusCode == 200){
    final rawText = jsonDecode(response.body);
    final reply = rawText['candidates'][0]['content']['parts'][0]['text']; // needed as even text is returned in json format
    savemessage(reply,false);
    print(reply);
    }
  }
  catch(e){
    savemessage("something went wrong!",false);
    print("exception caught $e");
  }

}