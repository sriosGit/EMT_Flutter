import 'package:SoyVidaApp/services/homeService.dart';
import 'package:flutter/material.dart';

class AskHelpScreen extends StatefulWidget {
  @override
  _AskHelpScreenState createState() => _AskHelpScreenState();
}

class _AskHelpScreenState extends State<AskHelpScreen> {
  final requestHelpText = TextEditingController();
  final userId = 1;
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBydWViYXNAZ21haWwuY29tIiwianRpIjoiYWI5MWE0YjQtMjEyZS00YTJmLWI3YWEtZWU4MWVhZTM4Mzk1IiwiZXhwIjoxNTk5MTc2MjY4LCJpc3MiOiJUZXN0LmNvbSIsImF1ZCI6IlRlc3QuY29tIn0.rfL0yNnl4R3Ou0Q36pplyocrvHAa6vaQyLnaRojk-Co";
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    requestHelpText.dispose();
    super.dispose();
  }

  Future<void> _showOkDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Solicitud enviada'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hola, recibimos tu solicitud!'),
                SizedBox(height: 20),
                Text(
                    'Nuestros especialistas trabajarán los más rápido posible y se comunicarán contigo muy pronto.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Gracias',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool onSuccessSend(res) {
    print(res);
    requestHelpText.clear();
    _showOkDialog();
    return true;
  }

  bool onErrorSend(res) {
    print(res);
    print("Error SignUp ");
    return true;
  }

  void _onSendRequestHelp() {
    print("ON CLICK REQUEST HELP");
    requestHelp(
      userId,
      token,
      requestHelpText.text,
      onSuccessSend,
      onErrorSend,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text(
            "Registro de solicitud",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 12.0, left: 30, right: 30, bottom: 12),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: requestHelpText,
                maxLines: 12,
                decoration: InputDecoration.collapsed(
                    hintText: "Por favor, dinos en que podemos ayudarte"),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: Container(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
            child: Text(
              "Solicitar Ayuda",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          onPressed: () => {_onSendRequestHelp()},
        ),
      ],
    ));
  }
}
