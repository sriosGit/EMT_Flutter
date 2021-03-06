import 'dart:convert' as convert;
import 'package:EMT/config/apiUrls.dart';
import 'package:http/http.dart' as http;

class HttpUtil {
  void getRequest(url, successCallback, errorCallback) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview

    print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'origin': base,
      'x-requested-with': '*',
    };
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print("Exito");
      if (successCallback != null) {
        successCallback(jsonResponse);
      }
    } else {
      print("Error");
      if (errorCallback != null) {
        errorCallback(response);
      }
    }
  }

  dynamic getRawRequest(url) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview

    print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'origin': base,
      'x-requested-with': '*',
    };
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print("Exito");
      print(jsonResponse);
      return jsonResponse;
      // var itemCount = jsonResponse['totalItems'];
    } else {
      print("Error");
      return null;
    }
  }

  void postRequest(String url, params, Function successCallback,
      Function errorCallback) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview

    // Await the http get response, then decode the json-formatted response.
    print(url);
    var body = convert.jsonEncode(params);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'origin': base,
      'x-requested-with': '*',
    };
    var response = await http.post(url, body: body, headers: headers);
    if (response.body.isNotEmpty) {
      print(response.body);
      print("Exito");
      var jsonResponse = convert.jsonDecode(response.body);
      if (successCallback != null) {
        successCallback(jsonResponse);
      }
    } else {
      print("Error");
      var jsonResponse = convert.jsonDecode(response.body);
      if (errorCallback != null) {
        errorCallback(jsonResponse);
      }
    }
  }

  void putRequest(String url, params, Function successCallback,
      Function errorCallback) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview

    // Await the http get response, then decode the json-formatted response.
    var body = convert.jsonEncode(params);
    print(body);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'origin': base,
      'x-requested-with': '*',
    };
    var response = await http.put(url, body: body, headers: headers);

    if (response.body.isNotEmpty) {
      print("Exito");
      var jsonResponse = convert.jsonDecode(response.body);
      if (successCallback != null) {
        successCallback(jsonResponse);
      }
    } else {
      print("Error");
      var jsonResponse = convert.jsonDecode(response.body);
      if (errorCallback != null) {
        errorCallback(jsonResponse);
      }
    }
  }
}
