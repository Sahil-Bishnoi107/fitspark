import 'package:fitspark/providers/chatProvider.dart';
import 'package:fitspark/providers/exerciseProvider.dart';
import 'package:fitspark/providers/searchprovider.dart';
import 'package:fitspark/screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('Today');
  await Hive.openBox('breakfast');
  await Hive.openBox('lunch');
  await Hive.openBox('snacks');
  await Hive.openBox('dinner');
  await Hive.openBox('Target');
  await Hive.openBox('meals');
  await Hive.openBox('chats');
  await Hive.openBox('exercises');
  await Hive.openBox('todayexe');
  
  runApp(
   
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => Chatprovider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
        
      ],
      child: MyApp()));
}

class MyApp extends StatefulWidget{
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyApp();
}
class _MyApp extends State<MyApp>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Homepage(),
    );
  }
}