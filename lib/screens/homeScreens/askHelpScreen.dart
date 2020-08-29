import 'package:flutter/material.dart';

class AskHelpScreen extends StatefulWidget {
  @override
  _AskHelpScreenState createState() => _AskHelpScreenState();
}

class _AskHelpScreenState extends State<AskHelpScreen> {
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
          onPressed: () => {},
        ),
      ],
    ));
  }
}
