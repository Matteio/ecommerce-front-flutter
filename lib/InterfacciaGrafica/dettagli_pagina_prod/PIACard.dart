import 'package:flutter/material.dart';
import 'package:front_shop/InterfacciaGrafica/dettagli_pagina_prod/product_page.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Login.dart';
import 'package:front_shop/model/oggetti/ProdottoInAcquisto.dart';
import 'package:front_shop/model/support/Constants.dart';

import 'CartCounter.dart';

class PIACard extends StatefulWidget {

  final ProdottoInAcquisto pia;
  final Function callback;
  final String email;

  const PIACard({Key? key,
  required this.pia,
  required this.callback,
  required this.email}) : super(key: key);

  @override
  State<PIACard> createState() => _PIACardState();
}

enum StatoProdotto{
  available,
  unavailable,
  lessAvailable,
  disabled,
}

class _PIACardState extends State<PIACard> {

  StatoProdotto statoProdotto=StatoProdotto.available;

  @override
  void initState(){
    super.initState();
    if(widget.pia.prodotto.disponibilita==0){
      statoProdotto=StatoProdotto.unavailable;
    }else if(widget.pia.quantita>widget.pia.prodotto.disponibilita){
      statoProdotto=StatoProdotto.lessAvailable;
    }
  }//initState

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaginaProdotto(prodotto: widget.pia.prodotto)));
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orangeAccent,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: Offset(0, 10),
                      blurRadius: 20)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth:100,maxHeight: 100),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                      child: Image.network(widget.pia.prodotto.image)),
                ),
                Text(widget.pia.prodotto.nome, style: TextStyle(fontSize: 17),),
                Text("${widget.pia.prodotto.prezzo}€", style: TextStyle(fontSize: 17),),
                Text("Disponibilità: ${widget.pia.prodotto.disponibilita}pezzi ", style: TextStyle(fontSize: 17),),
                //alert(statoProdotto),
                CartCounter(
                    callback: widget.callback,
                    pia: widget.pia,
                    statoProdotto:statoProdotto,
                    email: Constants.EMAIL,
                ),//CartCounter
              ],
            ),
          )
        ],
      ),
    );
  }//build

  Column alert(StatoProdotto ps) {
    if (ps == StatoProdotto.unavailable) {
      return Column(
        children: [
          Icon(Icons.warning_amber_outlined, color: Colors.red,),
          Text("Prodotto non più disponibile",
            style: TextStyle(fontSize: 20, color: Colors.red),),
        ],
      );
    }
    else {
      return Column(
        children: [
          Icon(Icons.warning_amber_outlined, color: Colors.transparent,),
          Text("Prodotto disponibile",
            style: TextStyle(fontSize: 20, color: Colors.green),),
        ],
      );
    }
  }//alert

}//PIACard


