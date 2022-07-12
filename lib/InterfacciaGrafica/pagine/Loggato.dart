
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/InterfacciaGrafica/dettagli_pagina_prod/VisualizzaOrdini.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Layout.dart';
import 'package:front_shop/model/Model.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:front_shop/model/support/LogInResult.dart';

import '../../model/oggetti/Acquisto.dart';
import '../dettagli_pagina_prod/AcquistoCard.dart';

enum page{
  loggato,ordini
}

class Loggato extends StatefulWidget {
  const Loggato({Key? key}) : super(key: key);

  @override
  State<Loggato> createState() => _LoggatoState();
}

class _LoggatoState extends State<Loggato> {

  late Future<List<Acquisto>> ordini;
  page p=page.loggato;
  //List<Acquisto> orders;
  @override
  void initState(){
    print("prova");
    ordini=Model.sharedInstance.getMyOrdini(Constants.EMAIL);
    print("ordini: ");
    print(ordini);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return p==page.loggato?
    _Loggato(context):
    _VisualizzaOrdini(context);

  }//build


  Widget _Loggato(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFD95F13),
                Color(0xFFD55B2E),
                Color(0xFFDC7E45),
              ]
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Icon(FontAwesomeIcons.userCheck,size: 31),
              SizedBox(height: 15,),
              Text('ShopSite',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 31,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30,),
                Container(
                  height: 300,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Text('Bentornato!',
                        style: TextStyle(
                          fontSize: 35,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('Hai eseguito correttamente il Login',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 25,),
                      GestureDetector(
                        onTap: () => {/*setState((){
                          p=page.ordini;
                        })*/},
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFFFF0000),
                                    Color(0xFFE82B2B),
                                    Color(0xFFE75B5B),
                                  ]
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text('Visualizza Ordini',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () => {logoutDc()},
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFFF0000),
                                Color(0xFFE82B2B),
                                Color(0xFFE75B5B),
                              ]
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text('Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                      ),
                    ),
                    ],
                  ),
                ),
            ],//children
          ),
        ),
      ),
    );
  }//loggato

  Widget _VisualizzaOrdini(BuildContext context){
    print("Visualizza ordini");
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        /*child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFD95F13),
                Color(0xFFD55B2E),
                Color(0xFFDC7E45),
              ]
            )
          ),*/
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.only(bottom:10,left: 5,right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orangeAccent,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                child: Column(
                  children: [
                    Text(
                      "Ordini effettuati",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: size.height/4,minWidth: size.width,maxHeight: size.height/1.5,maxWidth:size.width ),
                      child: FutureBuilder(
                      future: ordini,
                      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot){
                        if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                        print("AO");
                        print(snapshot.data);
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                          child: snapshot.data!.length>0?
                            ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context,i){
                              print("VADO_IN_ACQUISTOCARD");
                              return AcquistoCard(
                                acquisto:snapshot.data![i],
                              );
                            },
                          ):
                          Stack(
                            children: [
                            Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            margin: EdgeInsets.only(top:10,bottom:10,left: 6,right: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.orangeAccent,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).hintColor.withOpacity(0.2),
                                      offset: Offset(0, 10),
                                      blurRadius: 20),
                                ]),
                            ),],),
                        );
                        }//if
                        else{
                          print("ELSE");
                          return CircularProgressIndicator();
                        }
                      }//builder
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
            ],),
      ),
    );
  }//visualizzaOrdini

  void logoutDc(){
    Layout.setLogState(LogInResult.error_wrong_credentials);
    Constants.EMAIL="";
    print("Logout");
  }//logoutDc

}
