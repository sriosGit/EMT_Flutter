import 'package:SoyVidaApp/config/apiUrls.dart';
import 'package:SoyVidaApp/utils/httpUtil.dart';

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
