import 'dart:async';
import 'dart:convert';
import 'package:front_shop/model/oggetti/Prodotto.dart';
import 'package:http/http.dart' as http;
import 'package:front_shop/model/manager/RestManager.dart';
import 'package:front_shop/model/oggetti/AuthenticationData.dart';
import 'package:front_shop/model/support/Constants.dart';
import 'package:front_shop/model/support/LogInResult.dart';

import '../Admin/ProdService.dart';
import 'oggetti/Utente.dart';

class Model{

  static Model sharedInstance = Model();

  ProdService _prodService=ProdService();
  RestManager _restManager=RestManager();

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
    List<Prodotto> listaProdotti =
        prodottiData.map((json) => Prodotto.fromJson(json)).toList();
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

  /*Future<Utente> addUser(Utente user) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return ; // not the best solution
      }
      else {
        return Utente.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return; // not the best solution
    }
  }*/

}//Model