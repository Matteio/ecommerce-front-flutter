
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

enum TypeHeaderC {
  json,
  urlencoded
}

class CartManager{
  String token="";


  // ignore: unused_element
  Future<String> _makeRequest(String serverAddress,String servicePath,String method,TypeHeaderC type,{ Map<String, String>? params, dynamic body})async{
    Uri uri = Uri.http(serverAddress, servicePath, params);
    print("uri: "+uri.toString());
    int i=0;
    int tents=3;

    while(i<tents) {
      i++;
      try {
        var response;
        String contentType="application/json;charset=utf-8";
        dynamic formattedBody;
        if (type == TypeHeaderC.json) {
          contentType = "application/json;charset=utf-8";
          formattedBody = json.encode(body);
        }
        else {
          contentType = "application/x-www-form-urlencoded";
          formattedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
        }
        Map<String, String> headers = {};
        headers[HttpHeaders.contentTypeHeader] = contentType;
        if (token != "") {
          headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        }
        switch (method) {

          case "post":
            print("caso post");
            print(headers.toString());
            print(formattedBody);
            response = await post(
              uri,
              headers: headers,
              body: formattedBody,
            );
            print("response: "+response.toString());
            break;
          case "get":
            print("Caso get");
            response = await get(
              uri,
              headers: headers,
            );
            print("response"+response.body);
            break;
        }
        //print("response.body: "+response.body);
        return response.body;

      } catch (err) {
        print(err.toString());
        await Future.delayed(const Duration(seconds: 5), () => null);
      }
    }
    return "fail";
  }

  Future<String> makePostRequest(String serverAddress, String servicePath, {dynamic body,Map<String, String>? params, TypeHeaderC type = TypeHeaderC.json}) async {
    print("makePostRequestCart");
    //print("body: "+body.toString());
    return _makeRequest(serverAddress, servicePath, "post", type, body: body,params: params);
  }

  Future<String> makeGetRequest(String serverAddress, String servicePath, {Map<String, String>? params, TypeHeaderC type = TypeHeaderC.json}) async {
    print("MakeGetRequest di cart");
    return _makeRequest(serverAddress, servicePath, "get", type, params: params);
  }


}