import 'dart:convert';
import 'package:front_shop/model/support/Constants.dart';
import 'package:http/http.dart' as http;

class ProdService {
  Map<String, String> headers = {
    //"content-type": "application/json",
    "content-type": "application/x-www-form-urlencoded",
    "accept": "application/json",
  };

  Future<http.Response> get(String url, Map<String, String> params) async {
    try {
      Uri uri = Uri.parse(Constants.ADDRESS_STORE_SERVER + url).replace(queryParameters: params);
      // params /*String|Iterable<String>*/
      http.Response response = await http.get(uri);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(Constants.ADDRESS_STORE_SERVER + url);
      String bodyString = json.encode(body);
      http.Response response =
        await http.post(uri, headers: headers, body: bodyString);
      print("respons"+response.body);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

 /* Future<String> post1(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(Constants.ADDRESS_STORE_SERVER + url);
      String bodyString = json.encode(body);
      String response =
        await http.post(uri, headers: headers, body: bodyString).toString();
      return response;
    } catch (e) {
      return "Porcodio";
    }
  }*/


  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(Constants.ADDRESS_STORE_SERVER + url);
      String bodyString = json.encode(body);
      http.Response response =
        await http.put(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> delete(String url) async {
    try {
      Uri uri = Uri.parse(Constants.ADDRESS_STORE_SERVER + url);
      http.Response response = await http.delete(uri, headers: headers);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

}