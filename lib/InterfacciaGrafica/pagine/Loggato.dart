
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/InterfacciaGrafica/pagine/Layout.dart';
import 'package:front_shop/model/support/LogInResult.dart';


class Loggato extends StatefulWidget {
  const Loggato({Key? key}) : super(key: key);

  @override
  State<Loggato> createState() => _LoggatoState();
}

class _LoggatoState extends State<Loggato> {
  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Icon(FontAwesomeIcons.userCheck,size: 31),
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
                  height: 300,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Text('Bentornato!',
                        style: TextStyle(
                          fontSize: 35,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('Hai eseguito correttamente il Login',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 25,),
                      GestureDetector(
                        onTap: () => {visualizzaOrdini()},
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
                            child: Text('Visualizza Ordini',
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
                      GestureDetector(
                        onTap: () => {logoutDc()},
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
                            child: Text('Logout',
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
                ),
            ],//children
          ),
        ),
      ),
    );
  }//build

  Widget visualizzaOrdini(){
    print("Visualizza ordini");
    return Scaffold(

    );
  }

  void logoutDc(){
    Layout.setLogState(LogInResult.error_wrong_credentials);
    print("Logout");
  }//logoutDc

}
