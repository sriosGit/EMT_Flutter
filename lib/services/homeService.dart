import 'package:EMT/config/apiUrls.dart';
import 'package:EMT/utils/httpUtil.dart';

void requestHelp(int userId, String token, String message, Function success,
    Function error) async {
  var params = {"id": userId, "token": token, "descripcion": message};
  print(params);
  HttpUtil client = new HttpUtil();
  client.postRequest(requestHelpUrl, params, success, error);
}

void addJournalEntry(
    String userId, String texto, Function success, Function error) async {
  var params = {"idEstduiante": userId, "texto": texto};
  print(params);
  HttpUtil client = new HttpUtil();
  client.postRequest(addJournalEntryUrl, params, success, error);
}

Future<dynamic> fetchActivities(
  int userId,
  String token,
  int type,
) async {
  var url = activitiesUrl +
      '?id=' +
      userId.toString() +
      '&token=' +
      token +
      '&estActidad=' +
      type.toString();
  HttpUtil client = new HttpUtil();
  return client.getRawRequest(url);
}

Future<dynamic> fetchJournalEntries(
  int userId,
  String token,
) async {
  var url = getJournalEntriesUrl + '?idEstudiante=' + userId.toString();
  HttpUtil client = new HttpUtil();
  return client.getRawRequest(url);
}

Future<dynamic> fetchAppointments(
  int userId,
  String token,
  int idEstado,
) async {
  var url = appointmentsUrl +
      '?idAuUser=' +
      userId.toString() +
      '&token=' +
      token +
      '&idEstado=' +
      idEstado.toString();
  HttpUtil client = new HttpUtil();
  return client.getRawRequest(url);
}

Future<dynamic> fetchEvaluations(
  int userId,
  String token,
  int type,
) async {
  var url = evaluationsUrl +
      '?idEst=' +
      userId.toString() +
      '&token=' +
      token +
      '&EstadoEva=' +
      type.toString();
  ;
  HttpUtil client = new HttpUtil();
  return client.getRawRequest(url);
}

Future<dynamic> fetchProfile(
  int userId,
  String token,
) async {
  var url =
      profileUrl + '?idEstudiante=' + userId.toString() + '&token=' + token;
  HttpUtil client = new HttpUtil();
  return client.getRawRequest(url);
}

void editUser(
    String estudianteId,
    String token,
    String firstName,
    String fatherName,
    String motherName,
    int phoneNumber,
    String email,
    int dni,
    String colegio,
    Function success,
    Function error) async {
  var params = {
    "id": estudianteId,
    "token": token,
    "correo": email,
    "nombreEstudiante": firstName,
    "estApellidoPaterno": fatherName,
    "estApellidoMaterno": motherName,
    "celularEstudiante": phoneNumber,
    "dniEstudiante": dni,
    "colegio": colegio,
  };

  print(params);
  HttpUtil client = new HttpUtil();
  var url = editUrl + "?id=$estudianteId&token=$token";
  client.postRequest(url, params, success, error);
}
