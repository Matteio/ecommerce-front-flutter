import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/UserRegistration.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Home.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Carrello.dart';
import 'package:front_shop/model/support/LogInResult.dart';

import '../../model/Model.dart';

class Login extends StatefulWidget{

  Login({Key? key}) : super(key:key);

  @override
  _LoginState createState() => _LoginState();

}//login

//Pagina di Login per utenti già registrati
class _LoginState extends State<Login>{

  bool _passwordVisible=false;

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass= TextEditingController();

  @override
  Widget build(BuildContext context){
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
                        onTap: () => {loginA()},
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
                        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new _UserRegistration())),
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
  }//build

  void login(String s){
    loginA();
  }//login

  void loginA() async{

    LogInResult result= await Model.sharedInstance.logIn(_controllerEmail.text,_controllerPass.text);
    if(result==LogInResult.logged){
      setState((){
        print("rcodio");
        //Layout.setLogState(LogInResult.logged);
      });
    }
  }

}//LoginState


//Pagina di registrazione dell'utente
class _UserRegistration extends StatelessWidget {

  @override
  Widget build(BuildContext context){
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
        ),
      ),
    );
  }//build

}//_UserRegistration

