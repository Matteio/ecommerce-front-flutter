/*
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/oggetti/Acquisto.dart';
import '../../model/support/Constants.dart';
import 'AcquistoCard.dart';

class VisualizzaOrdini extends StatefulWidget {
  const VisualizzaOrdini({Key? key}) : super(key: key);

  @override
  State<VisualizzaOrdini> createState() => _VisualizzaOrdiniState();
}

class _VisualizzaOrdiniState extends State<VisualizzaOrdini> {

  late Future<List<Acquisto>> ordini;

  @override
  void initState(){
    print("prova");
    ordini=Model.sharedInstance.getMyOrdini(Constants.EMAIL);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    print("Visualizza ordini");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Ordini effettuati",
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: size.height/4,minWidth: size.width,maxHeight: size.height,maxWidth:size.width ),
              child: FutureBuilder(
                  future: ordini,
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot){
                    if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,i){
                            return AcquistoCard(acquisto:snapshot.data![i]);
                          },
                        ),
                      );
                    }//if
                    else{
                      return CircularProgressIndicator();
                    }
                  }//builder
              ),
            ),
          ],//children
        ),
      ),
    );  }
}

*/