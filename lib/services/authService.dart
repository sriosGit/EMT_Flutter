import 'package:EMT/config/apiUrls.dart';
import 'package:EMT/utils/httpUtil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';

void login(
    String username, String password, Function success, Function error) async {
  var params = {"correo": username, "Password": password};
  print(params);
  HttpUtil client = new HttpUtil();
  client.postRequest(loginUrl, params, success, error);
}

void createUser(
    String firstName1,
    String firstName2,
    String lastName1,
    String lastName2,
    int phoneNumber,
    String email,
    String password,
    String rePassword,
    int dni,
    String role,
    Function success,
    Function error) async {
  var params = {
    "correo": email,
    "contrasena": password,
    "confirmarcontrasena": rePassword,
    "primerNombre": firstName1,
    "segundoNombre": firstName1,
    "primerApellido": lastName1,
    "segundoApellido": lastName2,
    "numeroCelular": phoneNumber,
    "dni": dni,
    "roleusuario": role,
  };
  print(params);
  HttpUtil client = new HttpUtil();
  client.putRequest(registerUrl, params, success, error);
}

void googleLogin() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // you can add extras if you require
    ],
  );

  _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
    GoogleSignInAuthentication auth = await acc.authentication;
    print(acc.id);
    print(acc.email);
    print(acc.displayName);
    print(acc.photoUrl);

    acc.authentication.then((GoogleSignInAuthentication auth) async {
      print(auth.idToken);
      print(auth.accessToken);
    });
  });
}

void facebookLogin() async {
  final facebookLogin = FacebookLogin();
  final facebookLoginResult = await facebookLogin.logIn(['email']);

  print(facebookLoginResult.accessToken);
  print(facebookLoginResult.accessToken.token);
  print(facebookLoginResult.accessToken.expires);
  print(facebookLoginResult.accessToken.permissions);
  print(facebookLoginResult.accessToken.userId);
  print(facebookLoginResult.accessToken.isValid());

  print(facebookLoginResult.errorMessage);
  print(facebookLoginResult.status);

  final token = facebookLoginResult.accessToken.token;

  /// for profile details also use the below code
  final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  final profile = json.decode(graphResponse.body);
  print(profile);
  /*
    from profile you will get the below params
    {
     "name": "Iiro Krankka",
     "first_name": "Iiro",
     "last_name": "Krankka",
     "email": "iiro.krankka\u0040gmail.com",
     "id": "<user id here>"
    }
   */
}
