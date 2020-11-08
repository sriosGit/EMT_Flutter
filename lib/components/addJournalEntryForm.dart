import 'dart:async';
import 'package:EMT/screens/homeScreen.dart';
import 'package:EMT/services/homeService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class AddJournalEntryForm extends StatefulWidget {
  final Function onSuccess;
  final Function onError;
  final int userId;
  final String texto;

  const AddJournalEntryForm(
      {Key key, this.userId, this.onSuccess, this.onError, this.texto})
      : super(key: key);

  @override
  _AddJournalEntryFormState createState() => _AddJournalEntryFormState();
}

class _AddJournalEntryFormState extends State<AddJournalEntryForm> {
  final GlobalKey<ScaffoldState> _scaffoldSignUpKey =
      new GlobalKey<ScaffoldState>();

  final entryTextController = TextEditingController();

  String token;
  String idEstudiante;
  bool showCompleteData = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    SessionDBUtil.db.getAllSessions().then((session) => {
          setState(() => {token = session.first.token}),
          setState(() => {idEstudiante = session.first.idEstudiante.toString()})
        });
  }

  void _onClickCreate() {
    print("ON CLICK CREATE JOURNAL ENTRY");
    _showLoaderDialog();
    setState(() => {loading = true});
    addJournalEntry(
      idEstudiante,
      entryTextController.text,
      onSuccessAdd,
      onErrorAdd,
    );
  }

  Future<bool> onSuccessAdd(res) async {
    setState(() => {loading = false});
    if (res is String)
      _scaffoldSignUpKey.currentState.showSnackBar(SnackBar(
        content: new Text(res),
        duration: new Duration(seconds: 10),
      ));
    Navigator.pop(context);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(goto: 0)));
    return true;
  }

  bool onErrorAdd(res) {
    _scaffoldSignUpKey.currentState.showSnackBar(SnackBar(
      content: new Text('Ocurrio un error intentlo más tarde'),
      duration: new Duration(seconds: 10),
    ));
    return true;
  }

  Future<void> _showLoaderDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldSignUpKey,
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                          child: Text(
                            "Volver",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () => {Navigator.pop(context)})
                    ],
                  ),
                  Container(
                    child: Center(
                      child: Text("Como estuvo tu día?",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: TextField(
                          controller: entryTextController,
                          maxLines: 12,
                          decoration: InputDecoration.collapsed(
                              hintText: "Escribe aquí tus pensamientos"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(30.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors
                                    .blue, //Color of the borderwidth of the border
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.blue,
                            onPressed: _onClickCreate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Registrar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            })));
  }
}
