
import 'dart:convert';

Prodotto prodottoFromJson(String s) => Prodotto.fromJson(json.decode(s));
String prodottoToJson(Prodotto p) => json.encode(p.toJson());

class Prodotto{

  dynamic idprodotto;
  String nome;
  String descrizione;
  double prezzo;
  int disponibilita;
  String image;

  Prodotto({
    this.idprodotto,
    required this.nome,
    required this.descrizione,
    required this.prezzo,
    required this.disponibilita,
    required this.image,
  });

  //Prodotto.empty();

  factory Prodotto.fromJson(Map<String, dynamic> json) => Prodotto(
        idprodotto: json['idprodotto'],
        nome: json['nome'],
        descrizione: json['descrizione'],
        prezzo: json['prezzo'],
        disponibilita: json['disponibilita'],
        image: json['image'],
    );//fromJson

  Map<String, dynamic> toJson() => {
      "idprodotto": idprodotto,
      "nome": nome,
      "descrizione": descrizione,
      "prezzo": prezzo,
      "disponibilita": disponibilita,
      "image": image,
  }; //toJson


  @override
  String toString() {
    return 'Prodotto{idProdotto: $idprodotto,'
        ' nome: $nome,'
        ' descrizione: $descrizione,'
        ' prezzo: $prezzo,'
        ' disponibilita: $disponibilita,'
        ' image: $image}';
  }

}//Prodotto