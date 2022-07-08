
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/model/Model.dart';
import 'package:front_shop/model/support/Constants.dart';
import '../../model/oggetti/Prodotto.dart';
import '../../model/support/Widget/ProductCard.dart';
import '../dettagli_pagina_prod/product_page.dart';

class Home extends StatefulWidget{

  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}

enum page {
  listaProd, prodotto
}

class _HomeState extends State<Home>{

  page p = page.listaProd;
  bool _searching = false;
  late Prodotto attuale;
  late List<Prodotto> _prodotti=<Prodotto>[];

  TextEditingController _searchFiledController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return p==page.listaProd?
        _listaProd():
        DettagliProdotto(attuale);
  }//build

  Widget _listaProd() {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            top(),
            bottom(),
          ],
        ),
      ),
    );
  }//listaProd

  Widget top() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Inserisci il nome del prodotto da cercare",
                labelText: "Cerca",
              ),
              controller: _searchFiledController,
              onFieldSubmitted: (value) {
                _search();
              },
            ),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.searchDollar),
            onPressed: () {
              _search();
            },
          ),
        ],
      ),
    );
  }//top

  void _search() {
    setState((){
      _searching=true;
      //_prodotti;
      print("ricerca");
    });
    _searchFiledController.text==null?
        Model.sharedInstance.getAll1().then((result){
          setState((){
            _searching=false;
            //print(result);
            _prodotti=result;
          });
        }):
    Model.sharedInstance.searchProdotto(_searchFiledController.text).then((result) {
      setState(() {
        _searching=false;
       // print(result);
        _prodotti=result;
        print(_prodotti);
      });
    });
  }//search

  Widget bottom() {
    return !_searching?
        _prodotti==<Prodotto>[]?
            SizedBox.shrink() :
            _prodotti.length==0?
              noResults() :
              yesResults() :
        CircularProgressIndicator();
  }//bottom


  Widget noResults() {
    return Text(
      "Nessun Risultato!",
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }//noResults


  Widget yesResults() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:53),
        child: GridView.builder(
          itemCount: _prodotti.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 300,
            mainAxisSpacing: 100,
            crossAxisSpacing: 50,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ProductCard(
            product: _prodotti[index],
            press: () => {
                attuale=_prodotti[index],
                setState((){p=page.prodotto;})
              }//press
            )
          ),
        ),
    );
  }//yesResults

  Widget DettagliProdotto(Prodotto prodotto){
    print("DettagliProdotto");
    return SingleChildScrollView(
      child: Column(
        children: <Widget> [
          SizedBox(
            height: 850,
            child: Stack(
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(top: 300 * 0),
                  padding: EdgeInsets.only(
                    top: 300 * 0.12,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
                PaginaProdotto(prodotto: prodotto)
              ],
            ),
          ),
        ],
      ),
    );
  }

}//search state