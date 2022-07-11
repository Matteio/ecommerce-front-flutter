import 'package:flutter/material.dart';

void snackBar(BuildContext context, String text, String azione){
  Color? color;
  if(azione=="ok")
    color=Colors.green;
  else if(azione=="no")
    color=Colors.red;
  final snackBar=SnackBar(
    content: Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),),
    duration: Duration(seconds: 1),
    backgroundColor: color,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.fixed,
  );//SnackBar
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
