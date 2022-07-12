import 'package:flutter/material.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Cart.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Home.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Layout.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Login.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primaryColor: Colors.orangeAccent
      ),
      debugShowCheckedModeBanner: false,
      home: Layout(title: Constants.APP_NAME),
      /*initialRoute: "LayoutPage",
      routes: {
        "/":(context)=>Layout(title: Constants.APP_NAME),
        "HomePage":(context)=>Home(),
        "LoginPage":(context)=>Login(),
        "CartPage":(context)=>Cart(),
        "LayoutPage":(context)=>Layout(title: Constants.APP_NAME),
      },*/
    );
  }//build

}//App