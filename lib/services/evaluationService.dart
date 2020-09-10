import 'package:EMT/config/apiUrls.dart';
import 'package:EMT/utils/httpUtil.dart';

Future<dynamic> fetchQuestions(
  int userId,
  int idEvaluacion,
  int idObjetoEvaluacion,
) async {
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
