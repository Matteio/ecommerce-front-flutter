import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Carrello.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Layout.dart';
import 'package:front_shop/model/Model.dart';
import 'package:front_shop/model/oggetti/Prodotto.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:front_shop/model/support/LogInResult.dart';
import 'package:get/get.dart';
import 'package:front_shop/InterfacciaGrafica/dettagli_pagina_prod/SnackBar.dart';
import '../behaviors/prod_contr.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Home.dart';

int numProdotti=1;

class PaginaProdotto extends StatelessWidget {

  //final ProductController productController = Get.put(ProductController());
  final Prodotto prodotto;
  const PaginaProdotto({Key? key, required this.prodotto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.35,
            padding: const EdgeInsets.only(top: 30),
            width: double.infinity,
            child: Image.network(prodotto.image),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  //child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prodotto.nome,
                              style: TextStyle(
                                fontSize: 40,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\€${prodotto.prezzo}',
                              style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          prodotto.descrizione,
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          "Disponibilità: "+prodotto.disponibilita.toString()+"pezzi",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        CartCount(
                          prodotto: prodotto,
                        ),
                      ],
                    ),
                  ),
                //),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.orangeAccent,
        padding: EdgeInsets.all(10),
        child:
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: /*IconButton(
                icon:*/ Icon(Icons.shopping_cart,size: 30,color: Colors.grey,),
                //onPressed: (){
                  //setState((){Layout.setLogState(LogInResult.logged);});
                //},
              //),
            ),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  _addToCart(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('+ Add to Cart',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );//scaffold
  }//build

  void _addToCart(BuildContext context){
    Model.sharedInstance.setQuantityToCart(Constants.EMAIL, prodotto.nome, numProdotti).then((value) {
      if(value==addToCartResult.setted){
        snackBar(context, "Prodotto aggiunto al carrello", "ok");
      }else if(value==addToCartResult.quantityUnavailable){
        snackBar(context, "Non puoi aggiungere una quantità>disponibilità", "no");
      }else{
        snackBar(context, "errore", "no");
      }
      numProdotti=1;
    });
  }//addToCart


}//NomeProdottoEImmagine

class CartCount extends StatefulWidget {

  final Prodotto prodotto;
  const CartCount({Key? key,required this.prodotto}) : super(key: key);

  @override
  State<CartCount> createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  //int numProdotti=1;

  @override
  Widget build(BuildContext context) {
    widget.prodotto;
    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Row(
              children: [
                buildOutlinedButton(
                    icon: Icons.remove,
                    press: (){
                      setState((){
                        if(numProdotti>1) {
                          numProdotti--;
                        }
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.4),
                  child: Text(
                    numProdotti.toString().padLeft(2,"0"),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                buildOutlinedButton(
                  icon: Icons.add,
                  press: () {
                    if(numProdotti<widget.prodotto.disponibilita){
                      setState((){
                        numProdotti++;
                      });
                    }//if
                  }),
              ],//children2
            ),

          ],//Children1
        ),
      ),
    );//FittedBox
  }//build

  ClipRRect buildOutlinedButton(
      {required IconData icon, required Function() press}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
              ),
          ),
            IconButton(
              onPressed: press,
              icon: Icon(icon,color: Colors.orangeAccent,),
            )
        ],
      ),
    );
  }//buildOutlinedButton

}//CartCounter


