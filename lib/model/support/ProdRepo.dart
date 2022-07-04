import 'dart:convert';

import 'package:front_shop/model/manager/ProdService.dart';
import 'package:http/http.dart' as http;
import '../oggetti/Prodotto.dart';
import 'Constants.dart';

class ProdRepo {

  final ProdService _prodService = ProdService();

  Future<Map<String,dynamic>> getProdotti(int page,
      String?prodCercato, SortTipi? sortTipi)async{
    Map<String,String> params = {
      "pag": page.toString(),
      "limite": Constants.PAGE_LIMIT.toString(),
    };
    if (prodCercato != null)
      params["nomeProd"] = prodCercato;
    if (sortTipi != null) {
      params["sort"] = sortTipi.toString().split('.').last;
    }
    http.Response response = await _prodService.get(Constants.REQUEST_SEARCH_PRODUCTS, params);
    dynamic responseJson = jsonDecode(response.body);
    final prodottiData = responseJson['data']['content'] as List;
    List<Prodotto> listaProdotti = prodottiData.map((json) => Prodotto.fromJson(json)).toList();
    final pagineData = responseJson['data']['totalPages'];
    Map<String,dynamic> datiRet = {
      "lista prodotti": listaProdotti,
      "numero pagina": pagineData
    };
    return datiRet;
  }


  Future<Prodotto> aggiungiProdotto(Prodotto prodotto) async{
    http.Response response = await _prodService.post(Constants.REQUEST_ADD_PRODUCTS, prodotto.toJson(prodotto));
    dynamic responseJson = jsonDecode(response.body);
    final jsonData = responseJson['data'];
    Prodotto prodottoSalvato = Prodotto.fromJson(jsonData);
    return prodottoSalvato;
  }

  Future<Prodotto> modificaProdotto(Prodotto prodotto) async{
    http.Response response = await _prodService.put(Constants.REQUEST_EDIT_PRODUCTS, prodotto.toJson(prodotto));
    dynamic responseJson = jsonDecode(response.body);
    final jsonData = responseJson['data'];
    Prodotto prodottoModificato = Prodotto.fromJson(jsonData);
    return prodottoModificato;
  }

  Future<dynamic> eliminaProdotto(Prodotto prodotto) async{
    http.Response response = await _prodService.delete(Constants.REQUEST_DELETE_PRODUCTS+"${prodotto.idProdotto}");
    dynamic responseJson = jsonDecode(response.body);
    final jsonMessage = responseJson['message'];
  }

}//ProdRepo