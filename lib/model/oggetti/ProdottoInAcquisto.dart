import 'dart:convert';

import 'package:front_shop/model/oggetti/Prodotto.dart';

import 'Utente.dart';

ProdottoInAcquisto acquistoFromJson(String s) => ProdottoInAcquisto.fromJson(json.decode(s));
String acquistoToJson(ProdottoInAcquisto p) => json.encode(p.toJson());

class ProdottoInAcquisto{

  dynamic idprodcarrello;
  Utente compratore;
  Prodotto prodotto;
  int quantita;

  ProdottoInAcquisto({
    this.idprodcarrello,
    required this.compratore,
    required this.prodotto,
    required this.quantita
  });

  factory ProdottoInAcquisto.fromJson(Map<String, dynamic> json){
    return ProdottoInAcquisto(
      idprodcarrello: json['idprodcarrello'],
      compratore: Utente.fromJson(json['compratore']),
      prodotto: Prodotto.fromJson(json['prodotto']),
      quantita: json['quantita'],
    );
  }//fromJson

  Map<String,dynamic> toJson() => {
    "idprodcarrello": idprodcarrello,
    "quantita": quantita,
    "prodotto":prodotto,
    "compratore":compratore
  };

}//ProdottoInAcquisto