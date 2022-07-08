class Utente {

  //int idUtente;
  String codiceFiscale;
  String nome;
  String cognome;
  String telefono;
  String email;
  String indirizzo;

  Utente({required this.codiceFiscale, /*required this.codice,*/ required this.nome,
    required this.cognome,required this.telefono,required this.email,
     required this.indirizzo});

  factory Utente.fromJson(Map<String, dynamic> json){
    return Utente(
      //idUtente: json['idUtente'],
      codiceFiscale: json['codiceFiscale'],
      nome: json['nome'],
      cognome: json['cognome'],
      telefono: json['telefono'],
      email: json['email'],
      indirizzo: json['indirizzo'],
    );
  }

  Map<String, dynamic> toJson() => {
   // 'idUtente': idUtente,
    'codiceFiscale': codiceFiscale,
    'nome': nome,
    'cognome': cognome,
    'telefono': telefono,
    'email': email,
    'indirizzo': indirizzo,
  };

  /*  @override
  String toString(){
    return nome+" "+cognome;
  }//toString */

}//Utente