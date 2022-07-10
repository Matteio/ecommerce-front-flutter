
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/oggetti/ProdottoInAcquisto.dart';

class Carrello extends StatefulWidget{
  Carrello({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

enum page{
  vuoto, prod
}

class _CartState extends State<Carrello>{

  page p=page.vuoto;
  bool _searching = false;
  List<ProdottoInAcquisto> prodotti=<ProdottoInAcquisto>[];
  //late Ordine ordine=new Ordine(dataAcquisto: , utente: utente);

  @override
  Widget build(BuildContext context){
    return prodotti==null?
        _cartVuoto():
        _cart();
  }

  Widget _cartVuoto(){
    print("cartVuoto");
    return Scaffold(
      //backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
              child: Text(
                "Il tuo carrello è vuoto",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
              child: Icon(
                FontAwesomeIcons.shoppingCart,
                size: 222,
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }//_cartVuoto

  Widget _cart(){
    return Scaffold(

    );
  }//_cart



}