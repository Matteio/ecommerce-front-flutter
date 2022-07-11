import 'package:flutter/material.dart';
import 'package:front_shop/InterfacciaGrafica/dettagli_pagina_prod/PIACard.dart';
import 'package:front_shop/model/Model.dart';
import 'package:front_shop/model/oggetti/ProdottoInAcquisto.dart';
import 'package:front_shop/model/support/Constants.dart';
import '../../model/oggetti/Utente.dart';
import 'package:front_shop/InterfacciaGrafica/dettagli_pagina_prod/SnackBar.dart';


class CartCounter extends StatefulWidget {

  final ProdottoInAcquisto pia;
  final Function callback;
  final StatoProdotto statoProdotto;
  final String email;

  const CartCounter
      ({Key? key,
      required this.pia,
      required this.callback,
      required this.statoProdotto,
      required this.email
      }) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState(callback: callback);
}

class _CartCounterState extends State<CartCounter> {

  int numeroProdotti = 1;
  final Function callback;

  _CartCounterState({required this.callback});

  @override
  void initState() {
    numeroProdotti = widget.pia.quantita;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: widget.statoProdotto == StatoProdotto.unavailable ?
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildOutlinedButton(
                statoProdotto: widget.statoProdotto,
                icon: Icons.remove,
                press: () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "0".padLeft(2, "0"),
                style: TextStyle(fontSize: 10),
              ),
            ),
            buildOutlinedButton(
                statoProdotto: widget.statoProdotto,
                icon: Icons.add,
                press: () {}),
            IconButton(onPressed: () {
              Model.sharedInstance.removeFromCart(Constants.EMAIL,widget.pia.prodotto.nome)
                  .then((value) {
                callback();
                snackBar(context, "Prodotto rimosso", "ok");
              });
            }, icon: Icon(Icons.delete, color: Colors.red,))

      ],
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildOutlinedButton(
                statoProdotto: widget.statoProdotto,
                icon: Icons.remove,
                press: () {
                  setState(() {
                    if (numeroProdotti > 1) {
                      numeroProdotti--;
                      Model.sharedInstance.setQuantityToCart(
                          widget.email, widget.pia.prodotto.nome,
                          numeroProdotti).then((value) {
                        callback();
                      });
                      /*callback();*/
                    }
                  });
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                numeroProdotti.toString().padLeft(2, "0"),
                style: TextStyle(fontSize: 10),
              ),
            ),
            buildOutlinedButton(
                statoProdotto: widget.statoProdotto,
                icon: Icons.add,
                press: () {
                  if (numeroProdotti < widget.pia.prodotto.disponibilita) {
                    setState(() {
                      numeroProdotti++;
                      Model.sharedInstance.setQuantityToCart(
                          widget.email, widget.pia.prodotto.nome,
                          numeroProdotti).then((value) {
                        callback();
                      });
                    });
                  }
                }),
            IconButton(onPressed: () {
              Model.sharedInstance.removeFromCart(Constants.EMAIL,widget.pia.prodotto.nome)
                  .then((value) {
                callback();
                snackBar(context, "Prodotto rimosso", "ok");
              });
            }, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  } //build

  ClipRRect buildOutlinedButton(
      {required IconData icon, required Function() press, required StatoProdotto statoProdotto}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: statoProdotto == StatoProdotto.unavailable ? Container(
                decoration: const BoxDecoration(
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
              ) : Container(
                decoration: const BoxDecoration(
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
              )
          ),
          IconButton(
              onPressed: press,
              icon: Icon(
                icon,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
