import 'dart:convert';

import 'package:front_shop/model/oggetti/Utente.dart';

import 'Prodotto.dart';

Acquisto acquistoFromJson(String s) => Acquisto.fromJson(json.decode(s));

String purchaseToJson(Acquisto a) => json.encode(a.toJson());


class Acquisto{

  dynamic idacquisto;
  DateTime dataAcquisto;
  Utente compratore_a;
  Prodotto prodotto_a;
  int quantita;
  bool done;

  Acquisto({
    this.idacquisto,
    required this.dataAcquisto,
    required this.compratore_a,
    required this.prodotto_a,
    required this.quantita,
    required this.done
  });

  factory Acquisto.fromJson(Map<String,dynamic> json){
    return Acquisto(
      idacquisto: json["idacquisto"],
      dataAcquisto: DateTime.parse(json["dataAcquisto"].split("T"[0])), // <- prende solo il giorno
      compratore_a: Utente.fromJson(json["compratore_a"]),
      prodotto_a: Prodotto.fromJson(json["prodotto_a"]),
      quantita: json["quantita"],
      done: json["done"],
    );
  }//fromoJson

  Map<String,dynamic> toJson() => {
    "idacquisto": idacquisto,
    "dataAcquisto": dataAcquisto.toIso8601String(),
    "compratore_a": compratore_a.toJson(),
    "prodotto_a": prodotto_a.toJson(),
    "quantita": quantita,
    "done": done,
  };//toJson

  DateTime getDataAcquisto(){
    return dataAcquisto;
  }//getDA

}//Acquisto