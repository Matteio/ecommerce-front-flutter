
import 'package:flutter/material.dart';
import 'package:front_shop/model/oggetti/Prodotto.dart';

class ProdContainer extends StatelessWidget{
  final Prodotto prodotto;
  const ProdContainer({Key? key, required this.prodotto}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 210,
          width: 300,
          child: ClipRRect(
            child: Image.network(
              prodotto.image!,
              fit: BoxFit.cover,
              cacheHeight: 300,
              cacheWidth: 300,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          prodotto.nome!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          prodotto.prezzo.toString()+"\€",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

}//ProdContainer