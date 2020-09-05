import 'package:SoyVidaApp/config/apiUrls.dart';
import 'package:SoyVidaApp/utils/httpUtil.dart';

void requestHelp(int userId, String token, String message, Function success,
    Function error) async {
  var params = {"id": userId, "token": token, "descripcion": message};
  print(params);
  HttpUtil client = new HttpUtil();
  client.postRequest(requestHelpUrl, params, success, error);
}
