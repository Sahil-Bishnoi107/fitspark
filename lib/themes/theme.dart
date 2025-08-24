import 'dart:math';

import 'package:flutter/material.dart';
class MyTheme{
  String font = 'Nunito';


  //colors
  Color appbackground = const Color.fromRGBO(245, 245, 243, 1);
  Color appgrey = const Color.fromRGBO(130, 130, 150, 1);
  Color appgrey2 = const Color.fromRGBO(150, 150, 150, 1);
  Color darkgrey = const Color.fromRGBO(110, 110, 110, 1);
  Color lightgrey =  const Color.fromARGB(255, 234, 234, 234);
  Color percentagegreen = Colors.green;
  String bean = "assets/svgs/bean-svgrepo-com.svg";
  String fibre  = "assets/svgs/fibre.svg";
  String oil = "assets/svgs/oil.svg";
  Color p = const Color.fromRGBO(207, 216, 220, 0.6);
}

double roundUp(double num,int n){
  double mod = pow(10,n).toDouble();
  return (num*mod).ceil()/mod;
}