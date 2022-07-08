
import 'dart:typed_data';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front_shop/model/oggetti/Prodotto.dart';
import 'package:front_shop/model/support/Constants.dart';

class ProductCard extends StatelessWidget {
  final Prodotto product;
  final VoidCallback press;


  const ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(10),
              //height: 300,
              //width: 300,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(16),
                ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(product.image, fit: BoxFit.contain,),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.5),
            child: Text(
              product.nome,
              style: TextStyle(color: Constants.textLightColor),
            ),
          ),
          Text(
            "\€${product.prezzo}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }//build

} //ProductCard
