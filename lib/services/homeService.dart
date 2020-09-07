import 'package:SoyVidaApp/config/apiUrls.dart';
import 'package:SoyVidaApp/models/Activity.dart';
import 'package:SoyVidaApp/utils/httpUtil.dart';

void requestHelp(int userId, String token, String message, Function success,
    Function error) async {
  var params = {"id": userId, "token": token, "descripcion": message};
  print(params);
  HttpUtil client = new HttpUtil();
  client.postRequest(requestHelpUrl, params, success, error);
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

Future<dynamic> fetchAppointments(
  int userId,
  String token,
) async {
  var url = activitiesUrl + '?id=' + userId.toString() + '&token=' + token;
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
