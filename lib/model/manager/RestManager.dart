import 'dart:io';
import 'dart:convert';
import 'package:front_shop/Admin/ProdService.dart';
import 'package:http/http.dart';

import '../support/Constants.dart';
import '../support/ErrorListener.dart';


enum TypeHeader{
  json,
  urlencoded
}//TypeHeader

class RestManager{

  ErrorListener? delegate;
  String? token;

  Future<String> _makeRequest(String serverAddress, String servicePath, String method, TypeHeader type, {Map<String, String>? value, dynamic body}) async {
    print("uri: ");
    Uri uri = Uri.http(serverAddress, servicePath, value);
    print(uri);
    //Uri uri = Uri.parse("http://localhost:8080/auth/realms/shop/protocol/openid-connect/token");
    bool errorOccurred = false;
    var response;
    while ( true ) {
      try {
        //var response;
        //print("response: "+response.toString());
        // setting content type
        String contentType="application/json;charset=utf-8";
        dynamic formattedBody;
        if ( type == TypeHeader.json ) {
          contentType = "application/json;charset=utf-8";
          formattedBody = json.encode(body);
        }
        else if ( type == TypeHeader.urlencoded ) {
          contentType = "application/x-www-form-urlencoded";
          formattedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
        }
        // setting headers
        Map<String, String> headers = Map();
        headers[HttpHeaders.contentTypeHeader] = contentType;
        if ( token != null ) {
          headers[HttpHeaders.authorizationHeader] = 'bearer $token';
        }
        // making request
        switch ( method ) {
          case "post":
            print("CASO POST");
            print(headers.toString());
            print(formattedBody);
            response = await post(
              uri,
              headers: headers,
              body: formattedBody,
            );
            print("response_post: "+response.toString());
            break;
          case "get":
            response = await get(
              uri,
              headers: headers,
            );
            break;
          case "put":
            response = await put(
              uri,
              headers: headers,
            );
            break;
          case "delete":
            response = await delete(
              uri,
              headers: headers,
            );
            break;
        }
        if ( delegate != null && errorOccurred ) {
          delegate!.errorNetworkGone();
          errorOccurred = false;
        }
        return response.body;
      } catch(err) {
        if ( delegate != null && !errorOccurred ) {
          delegate!.errorNetworkOccurred(Constants.MESSAGE_CONNECTION_ERROR);
          errorOccurred = true;
        }
        print(response.toString());
        print("PorcodioERRORE");
        await Future.delayed(const Duration(seconds: 5), () => null); // not the best solution
      }
    }
  }

  Future<String> makePostRequest(String serverAddress, String servicePath, dynamic value, {TypeHeader type = TypeHeader.json}) async {
    print("MakePostRequest");
    return _makeRequest(serverAddress, servicePath, "post", type, body: value);
  }

  Future<String> makeGetRequest(String serverAddress, String servicePath, [Map<String, String>? value, TypeHeader? type]) async {
    return _makeRequest(serverAddress, servicePath, "get", type!, value: value);
  }

  Future<String> makePutRequest(String serverAddress, String servicePath, [Map<String, String>? value, TypeHeader? type]) async {
    return _makeRequest(serverAddress, servicePath, "put", type!, value: value);
  }

  Future<String> makeDeleteRequest(String serverAddress, String servicePath, [Map<String, String>? value, TypeHeader? type]) async {
    return _makeRequest(serverAddress, servicePath, "delete", type!, value: value);
  }

}//RestManager
