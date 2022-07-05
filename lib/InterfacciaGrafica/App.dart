import 'package:flutter/material.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Layout.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../Admin/ProdProv.dart';
import '../Admin/ProdottiAdmin.dart';

class App extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
      debugShowCheckedModeBanner: false,
      home: Layout(title: Constants.APP_NAME),
    );
  }//build

  /*
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<ProdProv>(
      create: (context) => ProdProv(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProdottiAdmin(),
        //home: Layout(title: Constants.APP_NAME),
      ),
    );
  }//build
  */

}//App