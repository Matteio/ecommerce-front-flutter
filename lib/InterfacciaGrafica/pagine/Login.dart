import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Home.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Carrello.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Layout.dart';
import 'package:front_shop/model/oggetti/Utente.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:front_shop/model/support/LogInResult.dart';
import 'package:front_shop/model/oggetti/User.dart';

import '../../model/Model.dart';

class Login extends StatefulWidget{

  Login({Key? key}) : super(key:key);

  @override
  _LoginState createState() => _LoginState();

}//login

enum page{
  login,registrazione,logging
}

//Pagina di Login per utenti già registrati
class _LoginState extends State<Login>{

  page p = page.login;
  bool _passwordVisible=false;
  Text _avviso=Text("");
  //late Utente attuale;


  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass= TextEditingController();

  TextEditingController _regControllerUser = TextEditingController();
  TextEditingController _regControllerEmail = TextEditingController();
  TextEditingController _regControllerPass = TextEditingController();
  TextEditingController _regControllerNome = TextEditingController();
  TextEditingController _regControllerCognome = TextEditingController();
  TextEditingController _regControllerTelefono = TextEditingController();
  TextEditingController _regControllerIndirizzo = TextEditingController();
  TextEditingController _regControllerCf = TextEditingController();

  @override
  Widget build(BuildContext context){
    return p==page.login?
        _LoginPage():
        p==page.registrazione?
            _UserRegister():
            const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
  }//build


  Widget _LoginPage(){
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD95F13),
                  Color(0xFFD55B2E),
                  Color(0xFFDC7E45),
                ]
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.
              center,
              children: [
                SizedBox(height: 100,),
                Icon(FontAwesomeIcons.doorOpen,size: 31),
                SizedBox(height: 15,),
                Text('ShopSite',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 31,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  height: 480,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Text('Benvenuto',
                        style: TextStyle(
                          fontSize: 35,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Esegui il Login nel tuo Account',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        child: TextFormField(
                          validator: (input) => !input!.contains("@")
                              ? "Inserisci una mail valida"
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Indirizzo Email',
                            suffixIcon: Icon(
                              FontAwesomeIcons.envelope,
                              size: 17,
                            ),
                          ),
                          controller: _controllerEmail,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          validator: (input) =>
                          input == null ? "Perfavore inserisci una password" : null,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Inserisci la tua Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                //Cambio l'icon in base alla visibilità della password
                                _passwordVisible
                                ?FontAwesomeIcons.eyeSlash
                                :FontAwesomeIcons.eye,
                                size:17,
                              ),
                              onPressed: () {
                                //Aggiorno lo stato ad ogni click dell'utente
                                setState(() {
                                 _passwordVisible=!_passwordVisible;
                                });
                              },
                            ),
                          ),
                          controller: _controllerPass,
                          onFieldSubmitted: login,
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () => {loginDc()},
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
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
                          child: Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text('Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text('Se non sei ancora registrato, Registrati!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        //onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new _UserRegistration())),
                        onTap: () {
                          setState((){p=page.registrazione;});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
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
                          child: Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );//Scaffold
  }//LoginPage

  void login(String s){
    loginDc();
  }//login

  void loginDc() async{
    setState((){
      p=page.logging;
    });
    //print(_controllerEmail.text);
    //print(_controllerPass.text);
    //print("Prendo il LoginResult");
    LogInResult result= await Model.sharedInstance.logIn(_controllerEmail.text,_controllerPass.text);
    if(result==LogInResult.logged){
      Constants.EMAIL=_controllerEmail.text;
      print("Constants: "+Constants.EMAIL);
      setState((){p=page.login;});
      Layout.setLogState(LogInResult.logged);
      print("Hai fatto l'accesso ");
      //utente=await Model.sharedInstance.getUtente(_controllerEmail.text,_controllerPass);
    }else{
      setState((){
        p=page.login;
        _avviso=const Text(
          "Errore nella fase di Login",
          style: TextStyle(
              color:Colors.red
          ),
        );
      });
    }
  }//LoginDc


  Widget _UserRegister(){
    print("USERREGISTRATION");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFD95F13),
                    Color(0xFFD55B2E),
                    Color(0xFFDC7E45),
                  ],
              ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Icon(FontAwesomeIcons.doorClosed,size: 31),
              SizedBox(height: 15,),
              Text('Registrati',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 31,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 530,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Codice Fiscale',
                        ),
                        controller: _regControllerCf,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nome',
                        ),
                        controller: _regControllerNome,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Cognome',
                        ),
                        controller: _regControllerCognome,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Telefono',
                        ),
                        controller: _regControllerTelefono,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Indirizzo',
                        ),
                        controller: _regControllerIndirizzo,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        validator: (input) => !input!.contains("@")
                            ? "Inserisci una mail valida"
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          suffixIcon: Icon(
                            FontAwesomeIcons.envelope,
                            size:17,
                          ),
                        ),
                        controller: _regControllerEmail,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          suffixIcon: Icon(
                            FontAwesomeIcons.user,
                            size: 17,
                          ),
                        ),
                        controller: _regControllerUser,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        validator: (input) =>
                        input == null ? "Perfavore inserisci una password" : null,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Inserisci la tua Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              //Cambio l'icon in base alla visibilità della password
                              _passwordVisible
                                  ?FontAwesomeIcons.eyeSlash
                                  :FontAwesomeIcons.eye,
                              size:17,
                            ),
                            onPressed: () {
                              //Aggiorno lo stato ad ogni click dell'utente
                              setState(() {
                                _passwordVisible=!_passwordVisible;
                              });
                            },
                          ),
                        ),
                        controller: _regControllerPass,
                        onFieldSubmitted: registrati,
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () => {registratiDc()},
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
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
                        child: Padding(
                          padding: EdgeInsets.all(13.0),
                          child: Text('Registrati',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],//children
                ),
              ),
            ],//children
          ),
        ),
      ),
    );
  }//userRegister

  void registrati(String s){
    registratiDc();
  }//registrati

  void registratiDc(){
    setState((){
      p=page.logging;
    });
    User u = User(
      email: _regControllerEmail.text,
      username: _regControllerUser.text,
      password: _regControllerPass.text,
      utente: Utente(
        codiceFiscale: _regControllerCf.text,
        nome: _regControllerNome.text,
        cognome: _regControllerCognome.text,
        indirizzo: _regControllerIndirizzo.text,
        email: _regControllerEmail.text,
        telefono: _regControllerTelefono.text
      )
    );
    Model.sharedInstance.registraUtente(u).then((value) {
      if(value.compareTo("registrazione completata")==0){
        setState((){
          _regControllerCf.clear();
          _regControllerNome.clear();
          _regControllerCognome.clear();
          _regControllerTelefono.clear();
          _regControllerIndirizzo.clear();
          _regControllerEmail.clear();
          _regControllerUser.clear();
          _regControllerPass.clear();
          _avviso=Text("");
          p=page.login;
        });
      }else{
        setState((){
          p=page.registrazione;
          _avviso=const Text(
            "Errore nella fase di registrazione",
            style: TextStyle(
              color:Colors.red
            ),
          );
        });
      }
    });//registraUtente
  }//registratiDc

}//LoginState
