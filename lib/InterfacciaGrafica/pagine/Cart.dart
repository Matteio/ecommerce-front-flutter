import 'package:flutter/material.dart';
import 'package:front_shop/model/Model.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'dart:ui';
import '../../model/oggetti/ProdottoInAcquisto.dart';
import '../dettagli_pagina_prod/PIACard.dart';
import 'package:front_shop/InterfacciaGrafica/dettagli_pagina_prod/SnackBar.dart';


class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  late Future<List<ProdottoInAcquisto>> cart;
  double totale=0.0;
  late List<ProdottoInAcquisto> pial;

  @override
  void initState(){
    super.initState();
    cartModificato();
  }//initState

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: size.width,minHeight: size.height/1.25, maxHeight: size.height/1.25),
              child: FutureBuilder(
                future: cart,
                builder: (BuildContext cntx, AsyncSnapshot<List> snapshot){
                  if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                    return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}
                    ),
                        child: snapshot.data!.length>0?
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,i){
                                return PIACard(
                                  email: Constants.EMAIL,
                                  pia: snapshot.data![i],
                                  callback: cartModificato,
                                );
                              }):
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.orangeAccent,
                                    boxShadow: [
                                      BoxShadow(
                                       color: Theme.of(context).hintColor.withOpacity(0.3),
                                       offset: Offset(0,10),
                                       blurRadius: 13
                                      )
                                    ]),
                                  child: Text(
                                    "Il carrello è vuoto!",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],//children2
                            )
                    );
                  }//if
                  else{
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],//children3
                    );
                  }//else
                },
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1000,
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.orangeAccent,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).hintColor.withOpacity(0.3),
                                offset: Offset(0,20),
                                blurRadius: 13
                            )
                          ]//boxShadow
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Totale: $totale€", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: () => {_acquistaOra()},
                            child: Container(
                              alignment: Alignment.center,
                              width: 150,
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
                                padding: EdgeInsets.all(3.0),
                                child: Text('Acquista ora',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],//children5
                      ),
                    ),
                  ],//children4
                ),
              ),
            ),
          ],//children1
        ),
      ),
    );//Scaffold
  }//build

  void cartModificato(){
    cart=Model.sharedInstance.getUserCart(Constants.EMAIL);
    cart.then( (value) {
      List<ProdottoInAcquisto> pial=value;
      setState((){
        totale=0.0;
        pial.forEach((element) {
          totale+=(element.prodotto.prezzo)*(element.quantita);
          totale=double.parse((totale).toStringAsFixed(2));
        });
      });
    });
  }//cartModificato

  void _acquistaOra(){
    cart.then((value) {
      cartModificato();
      if(value.length>0){
        Model.sharedInstance.acquistaCart(Constants.EMAIL).then((value) {
          if(value==HttpResult.done){
            cartModificato();
            snackBar(context, "Pagamento avvenuto con successo", "ok");
          }//if
          else if(value==HttpResult.cartIsEmpty){
            cartModificato();
            snackBar(context, "Carrello vuoto", "no");
          }
          else if(value==HttpResult.productDoesNotExist){
            cartModificato();
            snackBar(context, "Prodotto non più disponibile", "no");
          }
          else if(value==HttpResult.quantityUnavailable){
            cartModificato();
            snackBar(context, "Pagamento rifiutato", "no");
          }
          else{
            snackBar(context, "Errore", "no");
          }
        });
      } else{//if1
        snackBar(context, "Carrello vuoto", "no");
      }//else1
    });
  }//acquistaOra

}//Cart
