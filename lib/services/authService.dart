import 'package:EMT/config/apiUrls.dart';
import 'package:EMT/screens/homeScreen.dart';
import 'package:EMT/utils/httpUtil.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    String fbToken,
    String fbUserId,
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
    "tokenFacebook": fbToken,
    "idFacebook": fbUserId,
  };
  print(params);
  HttpUtil client = new HttpUtil();
  client.putRequest(registerUrl, params, success, error);
}

Future<Null> facebookLogin(onSuccess, onError, context) async {
  FacebookLogin facebookSignIn = new FacebookLogin();
  final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final FacebookAccessToken accessToken = result.accessToken;
      print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
      HttpUtil client = new HttpUtil();
      client
          .getRawRequest(fbCheckUrl + '?idFacebook=${accessToken.userId}')
          .then((res) => {
                if (res["fbId"] == "true")
                  {
                    SessionDBUtil.db.addSessionToDatabase({
                      "idEstudiante": res["idEstudiante"],
                      "token": res["token"],
                      "idFacebook": accessToken.userId,
                      "tokenFacebook": accessToken.token,
                    }).then((session) => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreen()))
                        }),
                  }
                else
                  {
                    client
                        .getRawRequest(
                            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}')
                        .then((graphResponse) =>
                            {onSuccess(accessToken, graphResponse)})
                  }
              });

      break;
    case FacebookLoginStatus.cancelledByUser:
      print('Login cancelled by the user.');
      break;
    case FacebookLoginStatus.error:
      print('Something went wrong with the login process.\n'
          'Here\'s the error Facebook gave us: ${result.errorMessage}');
      /*
      if (onError) {
        onError();
      }
      */
      break;
  }
}

Future<Null> _facebookLogOut() async {
  FacebookLogin facebookSignIn = new FacebookLogin();
  await facebookSignIn.logOut();
  print('Logged out.');
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
