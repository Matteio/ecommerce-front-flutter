class Utente {

  //int idUtente;
  //String codice;
  String nome;
  String cognome;
  String telefono;
  //String email;
  String indirizzo;

  Utente({/*required this.idUtente,required this.codice,*/required this.nome,
    required this.cognome,required this.telefono,/*required this.email,*/
     required this.indirizzo});

  factory Utente.fromJson(Map<String, dynamic> json){
    return Utente(
      //idUtente: json['idUtente'],
      //codice: json['codice'],
      nome: json['nome'],
      cognome: json['cognome'],
      telefono: json['telefono'],
      //email: json['email'],
      indirizzo: json['indirizzo'],
    );
  }

  Map<String, dynamic> toJson() => {
   // 'idUtente': idUtente,
    //'codice': codice,
    'nome': nome,
    'cognome': cognome,
    'telefono': telefono,
    //'email': email,
    'indirizzo': indirizzo,
  };

  /*  @override
  String toString(){
    return nome+" "+cognome;
  }//toString */

}//Utente