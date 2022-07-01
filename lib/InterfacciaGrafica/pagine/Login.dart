import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget{

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
                Icon(FontAwesomeIcons.doorOpen),
                SizedBox(height: 15,),
                Text('ShopSite',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
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
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Indirizzo Email',
                            suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(FontAwesomeIcons.eyeSlash, size: 17,),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
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
                    Text('Se non sei registrato, Registrati!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                      SizedBox(height: 20,),
                      GestureDetector(
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
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      );//Scaffold
  }//build

}//Login