import 'package:front_shop/model/oggetti/Utente.dart';

class User{

  Utente utente;
  String email;
  String username;
  String password;

  User({required this.utente, required this.email, required this.username,required this.password});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      utente: Utente.fromJson(json['utente']),
      email: json['email'],
      username: json['username'],
      password: json['password']
    );
  }//fromJson

  Map<String,dynamic> toJson() => {
    'utente': utente.toJson(),
    'email': email,
    'username': username,
    'password': password
  };//toJson

  @override
  String toString(){
    return email;
  }//toString

}//User