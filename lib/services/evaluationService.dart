import 'package:EMT/config/apiUrls.dart';
import 'package:EMT/utils/httpUtil.dart';

Future<dynamic> fetchQuestions(
  int userId,
  int idEvaluacion,
  int idObjetoEvaluacion,
) async {
  print(userId);
  print(idEvaluacion);
  print(idObjetoEvaluacion);
  var url = questionsUrl +
      '?idEstudiante=' +
      userId.toString() +
      '&idEvaluacion=' +
      idEvaluacion.toString() +
      '&idObjetoEvaluacion=' +
      idObjetoEvaluacion.toString();
  HttpUtil client = new HttpUtil();
  return client.getRawRequest(url);
}

void sendAnswers(List answers, Function success, Function error) async {
  var params = answers;
  HttpUtil client = new HttpUtil();
  client.postRequest(sendAnswersUrl, params, success, error);
}
