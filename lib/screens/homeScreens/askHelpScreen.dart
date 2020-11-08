import 'package:EMT/components/JournalEntryCard.dart';
import 'package:EMT/components/addJournalEntryForm.dart';
import 'package:EMT/models/JournalEntry.dart';
import 'package:EMT/services/homeService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class AskHelpScreen extends StatefulWidget {
  @override
  _AskHelpScreenState createState() => _AskHelpScreenState();
}

class _AskHelpScreenState extends State<AskHelpScreen> {
  final requestHelpText = TextEditingController();
  Future<dynamic> _journalEntries;
  int userId;
  String token;

  @override
  void initState() {
    super.initState();
    SessionDBUtil.db.getAllSessions().then((session) => {
          setState(() {
            print(session);
            userId = session.first.idEstudiante;
            token = session[0].token;
            _journalEntries = fetchJournalEntries(
                session.first.idEstudiante, session.first.token);
          })
        });
  }

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

  Widget renderNoResults(String message) {
    return (Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              height: 50.0,
              child: new TabBar(
                tabs: [
                  Text(
                    "Diario",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    "Solicitar Ayuda",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            FutureBuilder(
              future:
                  _journalEntries, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> children = [];
                if (snapshot.hasData) {
                  if (snapshot.data is String) {
                    children.add(renderNoResults(snapshot.data));
                  } else {
                    List<Widget> entries = new List<Widget>();
                    for (var i = 0; i < snapshot.data.length; i++) {
                      var entry = JournalEntry.fromJson(snapshot.data[i]);
                      entries.add(new JournalEntryCard(entry));
                      children = entries;
                    }
                  }
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error, Intentelo nuevamente'),
                    )
                  ];
                } else {
                  children = <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 60),
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ];
                }
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: FlatButton(
                          height: 50,
                          minWidth: double.infinity,
                          child: Text(
                            "Nueva entrada",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddJournalEntryForm(
                                    userId: userId,
                                  ),
                                ))
                          },
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Text(
                    "Registro de solicitud",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TextField(
                        controller: requestHelpText,
                        maxLines: 12,
                        decoration: InputDecoration.collapsed(
                            hintText:
                                "Por favor, dinos en que podemos ayudarte"),
                      ),
                    ),
                  ),
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
            ),
          ]),
        ),
      ),
    );
  }
}
