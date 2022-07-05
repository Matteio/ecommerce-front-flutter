import 'package:flutter/material.dart';

import 'package:front_shop/model/oggetti/Prodotto.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:front_shop/Admin/ProdRepo.dart';
import 'package:http/http.dart';
import '../model/Model.dart';

class ProdProv extends ChangeNotifier{

  List<Prodotto> prodotti = [];
  Prodotto? prodottoDaMod;
  int numPag=0;

  final ProdRepo _prodRepo = ProdRepo();

  getProdotti(int pag, String? prodCercato, SortTipi? sortTipi, GetTipi getTipi) async{
    Map<String,dynamic> datoRet =
      await _prodRepo.getProdotti(pag, prodCercato, sortTipi);
    List<Prodotto> paginaProdotti = datoRet["lista prodotti"];
    numPag=datoRet["numero pagina"];
    if(getTipi==GetTipi.PAGINAZIONE){
      prodotti=prodotti+paginaProdotti;
    }else if(getTipi==GetTipi.FILTRA){
      prodotti=paginaProdotti;
    }
    notifyListeners();
  }//getProdotti

  aggiungiProdotto(Prodotto prodotto) async {
    Prodotto prodottoSalvato =
        await _prodRepo.aggiungiProdotto(prodotto);
    prodotti.add(prodottoSalvato);
    notifyListeners();
  }//aggiungiProdotto

  modificaProdotto(Prodotto prodotto) async {
    Prodotto prodottoModificato =
        await _prodRepo.modificaProdotto(prodotto);
    prodotti[prodotti.indexOf(prodotto)]=prodottoModificato;
    notifyListeners();
  }//modificaProdotto

  eliminaProdotto(Prodotto prodotto) async{
    await _prodRepo.eliminaProdotto(prodotto);
    prodotti.remove(prodotto);
    notifyListeners();
  }//eliminaProdotto

}//ProdProv