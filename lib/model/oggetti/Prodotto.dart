class Prodotto{

  int idprodotto;
  String nome;
  String descrizione;
  double prezzo;
  int? disponibilita;
  String image;

  Prodotto({
    required this.idprodotto,
    required this.nome,
    required this.descrizione,
    required this.prezzo,
    required this.disponibilita,
    required this.image,
  });

  //Prodotto.empty();

  factory Prodotto.fromJson(Map<String, dynamic> json){
    return Prodotto(
        idprodotto: json['idprodotto'],
        nome: json['nome'],
        descrizione: json['descrizione'],
        prezzo: json['prezzo'],
        disponibilita: json['disponibilita'],
        image: json['image'],
    );
  }

  Map<String, dynamic> toJson(Prodotto prodotto){
    return {
      "idprodotto": prodotto.idprodotto,
      "nome": prodotto.nome,
      "descrizione": prodotto.descrizione,
      "prezzo": prodotto.prezzo,
      "disponibilita": prodotto.disponibilita,
      "image": prodotto.image,
    };
  }

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