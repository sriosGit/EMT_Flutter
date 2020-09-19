import 'package:EMT/models/Alternative.dart';
import 'package:EMT/models/Question.dart';
import 'package:EMT/services/evaluationService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class EvaluationPageView extends StatefulWidget {
  final int evaluationId;
  final int evaluationObjId;
  final int userId;
  final List answers = [];

  EvaluationPageView({
    Key key,
    @required this.evaluationId,
    @required this.evaluationObjId,
    @required this.userId,
  }) : super(key: key);
  @override
  _EvaluationPageViewState createState() => _EvaluationPageViewState();
}

class _EvaluationPageViewState extends State<EvaluationPageView>
    with TickerProviderStateMixin {
  Future<dynamic> _questions;
  int idPAlternativa = 0;
  int nombreAlternativa = 0;
  int puntaje = 0;
  int idpregunta = 0;
  @override
  void initState() {
    super.initState();
    SessionDBUtil.db.getAllSessions().then((session) => {
          setState(
            () => {
              _questions = fetchQuestions(
                  widget.userId, widget.evaluationId, widget.evaluationObjId)
            },
          )
        });
  }

  void saveAnswer() {
    if (idPAlternativa != 0) {
      widget.answers.add({
        "IdPAlternativa": idPAlternativa,
        "nombreAlternativa": nombreAlternativa,
        "puntaje": puntaje,
        "idpregunta": idpregunta,
        "idEvaluacion": widget.evaluationId,
      });
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  Widget renderStartBtn() {
    return FlatButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30.0)),
      color: Colors.blue,
      child: Text(
        "Empezar",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onPressed: () => {
        _controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn),
      },
    );
  }

  Widget renderBtn(question) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30.0)),
      color: Colors.blue,
      child: Text(
        question.btnText,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onPressed: saveAnswer,
    );
  }

  void onSuccessSend(res) {
    print(res);
    Navigator.pop(context);
  }

  void onErrorSend(res) {
    print(res);
  }

  Widget renderSendAnswersBtn() {
    return FlatButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30.0)),
      color: Colors.blue,
      child: Text(
        "Enviar respuestas",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onPressed: () =>
          {sendAnswers(widget.answers, onSuccessSend, onErrorSend)},
    );
  }

  Widget renderAlternatives(question) {
    List<Alternative> alternatives = question.alternatives;
    return Column(
        children: alternatives
            .map(
              (alternative) => RadioListTile<int>(
                title: Text(alternative.description),
                value: alternative.idPAlternativa,
                groupValue: idPAlternativa,
                onChanged: (value) {
                  setState(() {
                    idPAlternativa = value;
                    puntaje = alternative.puntaje;
                    idpregunta = question.id;
                  });
                },
              ),
            )
            .toList());
  }

  Widget onlyTextQuestion(question) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Container(
              child: Text(
                question.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: renderBtn(question),
            ),
          ],
        ),
      ),
    );
  }

  Widget radioQuestion(question) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
        child: Column(
          children: [
            Container(
              child: Text(
                question.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: renderAlternatives(question),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: renderBtn(question),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputTextQuestion(question) {
    String textInput = "";
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: <Widget>[
          Container(
            child: Text(
              question.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(question.body),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Ingresa aqui tu respuesta'),
            onChanged: (value) => textInput = value,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: renderBtn(question),
          ),
        ]),
      ),
    );
  }

  Widget renderWelcome(body) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
        child: Column(
          children: [
            Container(
              child: Text(
                body["nombreEvaluacion"],
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                body["descripcion"],
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: renderStartBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderThankYou() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "¡Muchas gracias por participar!",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: renderSendAnswersBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderQuestion(question) {
    /*
    if (question.type == "radio") {
      return radioQuestion(question);
    } else if (question.type == "inputText") {
      return inputTextQuestion(question);
    }
    return onlyTextQuestion(question);
    */
    return radioQuestion(question);
  }

  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Widget> questions = new List<Widget>();
          questions.add(renderWelcome(snapshot.data["item1"]));
          for (var i = 0; i < snapshot.data["item2"].length; i++) {
            var question = Question.fromJson(snapshot.data["item2"][i]);
            questions.add(renderQuestion(question));
          }
          questions.add(renderThankYou());
          children = questions;
        } else if (snapshot.hasError) {
          children = <Widget>[
            Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error, Intentelo nuevamente'),
                    )
                  ],
                ),
              ),
            ),
          ];
        } else {
          children = <Widget>[
            Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ];
        }
        return Container(
            color: Colors.white,
            child: PageView(
              controller: _controller,
              children: children,
              scrollDirection: Axis.horizontal,
            ));
      },
    );
  }
}
