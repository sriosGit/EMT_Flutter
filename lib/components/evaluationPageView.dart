import 'package:EMT/models/Alternative.dart';
import 'package:EMT/models/Question.dart';
import 'package:EMT/services/evaluationService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class EvaluationPageView extends StatefulWidget {
  final int evaluationId;
  final int evaluationObjId;
  final int userId;
  EvaluationPageView(
      {Key key,
      @required this.evaluationId,
      @required this.evaluationObjId,
      @required this.userId})
      : super(key: key);
  @override
  _EvaluationPageViewState createState() => _EvaluationPageViewState();
}

class _EvaluationPageViewState extends State<EvaluationPageView>
    with TickerProviderStateMixin {
  Future<dynamic> _questions;
  int _selected;

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

/*
  gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  _completeLogin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }
*/
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
      onPressed: () => {},
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
      onPressed: () => {},
    );
  }

  Widget renderAlternatives(question) {
    List<Alternative> alternatives = question.alternatives;
    return Column(
        children: alternatives
            .map(
              (alternative) => RadioListTile<int>(
                title: Text(alternative.description),
                value: alternative.value,
                groupValue: _selected,
                onChanged: (value) {
                  setState(() {
                    _selected = value;
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
              /*
              child: Text(
                question.body,
                style: TextStyle(fontSize: 16),
              ),
              */
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
    String selectedOption = "";
    print('jelo 2');
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
            /*
            Container(
              child: Text(question.body),
            ),
            */
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
        padding: EdgeInsets.symmetric(horizontal: 30.0),
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
              height: 30,
            ),
            Container(
              child: renderStartBtn(),
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
            padding: EdgeInsets.symmetric(vertical: 60.0),
            child: PageView(
              controller: _controller,
              children: children,
              scrollDirection: Axis.horizontal,
            ));
      },
    );
  }
}
