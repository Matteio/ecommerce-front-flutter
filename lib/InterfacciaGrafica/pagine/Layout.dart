import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Home.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Ricerca.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Login.dart';

class Layout extends StatefulWidget{

  final String title;

  Layout({Key? key,required String this.title}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState(title);
}//Layout

class _LayoutState extends State<Layout> {
  String title="";

  _LayoutState(String title) {
    this.title=title;
  }

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(5,5),
              ),
            ),
            title: Text(title),
            bottom: TabBar(
              tabs:[
                Tab(text: "home", icon: Icon(Icons.home_rounded)),
                Tab(text: "ricerca", icon: Icon(Icons.search_rounded)),
                Tab(text: "user", icon: Icon(Icons.person_rounded)),
              ],//tabs
            ),
          ),
          body: TabBarView(
            children: [
              Home(),
              Ricerca(),
              Login(),
            ],

          ),
        ),
    );//Default Tab Controoller


  }//build
}//LayoutState
