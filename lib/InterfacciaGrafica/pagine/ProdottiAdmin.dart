import 'package:flutter/material.dart';
import 'package:front_shop/model/Model.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:front_shop/model/support/ProdProv.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../model/support/Widget/AggiungiProdDraw.dart';
import '../../model/support/Widget/MyButton.dart';
import '../../model/support/Widget/ProdContainer.dart';

class ProdottiAdmin extends StatefulWidget{
  const ProdottiAdmin({Key? key}) : super(key: key);

  @override
  _ProdottiAdminState createState() => _ProdottiAdminState();
}//ProdottiAdmin

class _ProdottiAdminState extends State<ProdottiAdmin>{

  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  List<String> sortPer = ['Prezzo Crescente', 'Prezzo Decrescente', 'none'];
  SortTipi? sortTipi;
  String? sortVal;
  String? prodCercato;
  int numPag=0;
  int prossimaPag=1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<ProdProv>(context, listen: false).getProdotti(0, null, null, GetTipi.PAGINAZIONE);
      numPag = Provider.of<ProdProv>(context, listen: false).numPag;
    });
  }//initState

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.orange,
      key: _scaffoldKey,
      endDrawer: const AggiungiProdDraw(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Prodotti',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                MyButton(
                  text: 'Aggiungi Prodotto',
                  icon: Icons.add,
                  onPressed: () {
                    Provider.of<ProdProv>(context, listen: false).prodottoDaMod=null;
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding (
            padding: const EdgeInsets.only(right:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 130,
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      hintText: 'Cerca per nome..',
                      border: InputBorder.none,
                      prefixIcon: Icon(FontAwesomeIcons.search),
                    ),
                    onChanged: (input) {
                      prodCercato=input;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 167,
                  child: DropdownButton(
                    hint: const Text("Ordina per"),
                    value: sortVal,
                    items: sortPer.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      sortVal=value as String?;
                      if(value==sortPer[0]){
                        sortTipi=SortTipi.CRES;
                      }else if(value == sortPer[1]){
                        sortTipi=SortTipi.DECR;
                      }else{
                        sortTipi=null;
                      }
                      setState((){});
                    },
                  ),
                ),
                const SizedBox(width: 10),
                MyButton(
                  text: "Filtra",
                  icon: FontAwesomeIcons.filter,
                  color: Colors.black,
                  onPressed: () async {
                    await Provider.of<ProdProv>(context, listen: false)
                        .getProdotti(0, prodCercato, sortTipi, GetTipi.FILTRA);
                    numPag=Provider.of<ProdProv>(context, listen: false).numPag;
                    prossimaPag=1;
                    setState((){});
                  },
                )//MyButton
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ResponsiveGridList(
              desiredItemWidth: 200,
              minSpacing: 20,
              children: Provider.of<ProdProv>(context)
                  .prodotti.map<Widget>((prodotto) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<ProdProv>(context, listen: false).prodottoDaMod = prodotto;
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: ProdContainer(prodotto: prodotto),
                    );
              }).toList()
                ..add(
                  numPag>1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 210,
                              child: MyButton(
                                text: 'Carica di più',
                                icon: Icons.add,
                                color: Colors.grey,
                                onPressed: () {
                                  Provider.of<ProdProv>(context, listen: false).getProdotti(prossimaPag, prodCercato, sortTipi, GetTipi.PAGINAZIONE);
                                  numPag--;
                                  prossimaPag++;
                                },
                              ),
                            ),
                          ],
                  )
                      : const SizedBox(),
                ),
            ),
          ),
        ],
      ),
    );//Scaffoold
  }


}//ProdottiAdminState