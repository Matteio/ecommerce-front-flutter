import 'dart:async';
import 'dart:convert';
//import 'dart:ffi';
//import 'dart:ffi';
import 'package:front_shop/model/manager/CartManager.dart';
import 'package:front_shop/model/oggetti/Acquisto.dart';
import 'package:front_shop/model/oggetti/Prodotto.dart';
import 'package:front_shop/model/oggetti/ProdottoInAcquisto.dart';
import 'package:front_shop/model/oggetti/User.dart';
//import 'package:http/http.dart' as http;
import 'package:front_shop/model/manager/RestManager.dart';
import 'package:front_shop/model/oggetti/AuthenticationData.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:front_shop/model/support/LogInResult.dart';

import 'oggetti/Utente.dart';

enum addToCartResult{
  added,
  quantityUnavailable,
  setted,
  unknown
}
enum HttpResult{
  done,
  unknow,
  error,
  quantityUnavailable,
  alreadyExist,
  cartIsEmpty,
  productDoesNotExist
}

class Model{

  static Model sharedInstance = Model();

  //ProdService _prodService=ProdService();

  RestManager _restManager = RestManager();
  CartManager _cartManager = CartManager();

  late AuthenticationData _authenticationData;

  Future<LogInResult> logIn(String email, String password) async {
    try{
      print("Sono dentro il metodo logIn");
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      print("Chiamo il Manager mio");
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      //http.Response result = await _prodService.post(Constants.REQUEST_LOGIN, params);
      print("result: "+result);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      print("Authentication data"+_authenticationData.toString());
      if ( _authenticationData.hasError() ) {
        if ( _authenticationData.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _authenticationData.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = null;
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  /*Future<Map<String,dynamic>> getProdotti(int page,
      String? prodCercato, SortTipi? sortTipi)async{
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
    List<Prodotto> listaProdotti =
        prodottiData.map((json) => Prodotto.fromJson(json)).toList();
    final pagineData = responseJson['data']['totalPages'];
    Map<String,dynamic> datiRet = {
      "lista prodotti": listaProdotti,
      "numero pagina": pagineData
    };
    return datiRet;
  }*/

  Future<List<Prodotto>> getAll(int pageNumber, int pageSize, String sortBy) async {
    Map<String,String> params=Map();
    params["pageNumber"]=pageNumber.toString();
    params["pageSize"]=pageSize.toString();
    params["sortBy"]=sortBy;
    try{
      return List<Prodotto>.from(json.decode(
          await _cartManager.makeGetRequest(
            Constants.ADDRESS_STORE_SERVER,
            Constants.REQUEST_SEARCH_PRODUCTS_PAGED,
            params)).map((i) => Prodotto.fromJson(i)).toList());
    }catch(e){
      throw Exception("Errore nella restituzione dei prodotti paged");
    }
  }

  Future<List<Prodotto>> getAll1() async {
    try{
      return List<Prodotto>.from(json.decode(
        await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_SEARCH_PRODUCTS_ALL)).map((i) => Prodotto.fromJson(i)).toList());
    }catch(e){
      print(e);
      throw Exception("Errore nella ricerca del prodotto");
    }
  }

  Future<List<Prodotto>> searchProdotto(String name) async{
    Map<String,String> params = Map();
    print(name);
    params["name"] = name;
    try{
      print(params);
      return List<Prodotto>.from(json.decode(
          await _restManager.makeGetRequest(
              Constants.ADDRESS_STORE_SERVER,
              Constants.REQUEST_SEARCH_PRODUCTS_BY_NAME,
              params)).map((i) => Prodotto.fromJson(i)).toList());
    }catch(e){
      print(e);
      throw Exception("Errore nella ricerca del prodotto");
    }
  }//searchProdotto


  /*
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
  */


  Future<String> registraUtente(User u) async{
    return await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, "/r", u);
  }//registraUtente

  Future<List<Acquisto>> getMyOrdini() async{
    try{
      String res = await _cartManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_GET_ACQUISTI);
      List acquisti=jsonDecode(res);
      List<Acquisto> ret=acquisti.map((e) => new Acquisto.fromJson(e)).toList();
      return ret;
    }catch(err){
      print(err);
      return[];
    }
  }//getMyOrdini

  Future<List<ProdottoInAcquisto>> removeFromCart(String nomeProd) async{
    try{
      Map<String,String> params={};
      params["nomeProd"]=nomeProd;
      String res=await _cartManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_REMOVE_FROM_CART,params: params);
      List carrello=jsonDecode(res);
      return carrello.map((e) => ProdottoInAcquisto.fromJson(e)).toList();
    }catch(err){
      print(err);
      return [];
    }
  }//removeFromCart

  Future<HttpResult> acquistaCart() async{
    try{
      String res=await _cartManager.makePostRequest(Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_COMPRA_CART);
      if(res.contains(Constants.RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE))
        return HttpResult.quantityUnavailable;
      else if(res.contains(Constants.RESPONSE_ERROR_PRODUCT_NOT_FOUND))
        return HttpResult.productDoesNotExist;
      else if(res.contains(Constants.RESPONSE_ERROR_CART_IS_EMPTY))
        return HttpResult.cartIsEmpty;
      else
        return HttpResult.done;
    }catch(err){
      print(err);
      return HttpResult.unknow;
    }
  }

  Future<List<ProdottoInAcquisto>> getUserCart() async{
    try{
      String res=await _cartManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_GET_CART);
      List pia=jsonDecode(res);
      return pia.map((e) => ProdottoInAcquisto.fromJson(e)).toList();
    }catch(err){
      print(err);
      return [];
    }
  }

  Future<addToCartResult> addToCart(String email,String nomeProdotto,int quantita) async {
    try{
      Map<String,String> params={};
      params["email"]=email;
      params["nomeProdotto"]=nomeProdotto;
      params["quantita"]=quantita.toString();
      String res=await _cartManager.makePostRequest(Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_ADD_TO_CART);
      if(res.contains(Constants.RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE)){
        return addToCartResult.quantityUnavailable;
      }
      List pia=jsonDecode(res);
      return addToCartResult.added;
    }catch(err){
      print(err);
      return addToCartResult.unknown;
    }
  }

  Future<addToCartResult> setQuantityToCart(String email,String nomeProdotto,int quantita ) async{
    try{
      Map<String,String> params={};
      params["email"]=email;
      params["nomeProdotto"]=nomeProdotto;
      params["quantita"]=quantita.toString();
      String res=await _cartManager.makePostRequest(Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_SET_QTY_TO_CART);
      if(res.contains(Constants.RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE)){
        return addToCartResult.quantityUnavailable;
      }
      List pia=jsonDecode(res);
      return addToCartResult.setted;
    }catch(err){
      print(err);
      return addToCartResult.unknown;
    }
  }

  Future<HttpResult> setAcquistoDone(int id, bool done) async{
    try{
      Map<String,String> params=Map();
      params["done"]=done.toString();
      params["id"]=id.toString();
      String res=await _cartManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_SET_DONE);
      return HttpResult.done;
    }catch(err){
      print(err);
      return HttpResult.error;
    }
  }

}//Model