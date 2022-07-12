import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Cart.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Home.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Carrello.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Login.dart';
import 'package:front_shop/model/support/LogInResult.dart';

import 'Loggato.dart';

class Layout extends StatefulWidget{

  final String title;

  Layout({Key? key,required String this.title}) : super(key: key);
  static _LayoutState layout= _LayoutState() ;

  @override
  _LayoutState createState() => layout;

  static void setLogState(LogInResult l){
    layout.setLogResult(l);
  }

}//Layout

class _LayoutState extends State<Layout> {
  String title="shopSite";
  LogInResult logInResult=LogInResult.error_wrong_credentials;

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
            title: Text(title, style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 31,
            )),
            bottom: TabBar(
              tabs:[
                Tab(text: "Home", icon: Icon(FontAwesomeIcons.home)),
                Tab(text: "Carrello", icon: Icon(FontAwesomeIcons.shoppingCart)),
                Tab(text: "Utente", icon: Icon(FontAwesomeIcons.user)),
              ],//tabs
            ),
          ),
          body: getBody(),
          ),
    );
  }//build

  Widget getBody(){
    return logInResult==LogInResult.logged?
        TabBarView(children: [Home(), Cart(), Loggato()]):
    TabBarView(children: [
                Home(),
                // ProdottiAdmin(),
                //Carrello(),
                Cart(),
                Login(),
    ]);
  }

  void setLogResult(LogInResult l){
    setState((){
      this.logInResult=l;
    });
  }//setLogResult

}//LayoutState
