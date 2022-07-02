import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Home.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Carrello.dart';
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
                Tab(text: "Home", icon: Icon(FontAwesomeIcons.home)),
                Tab(text: "Utente", icon: Icon(FontAwesomeIcons.user)),
                Tab(text: "Carrello", icon: Icon(FontAwesomeIcons.shoppingCart)),
              ],//tabs
            ),
          ),
          body: TabBarView(
            children: [
              Home(),
              Login(),
              Carrello(),
            ],

          ),
        ),
    );//Default Tab Controoller
  }//build
}//LayoutState
