import 'package:EMT/models/Alternative.dart';
import 'package:EMT/models/Question.dart';
import 'package:EMT/screens/homeScreens/data.dart';
import 'package:flutter/material.dart';

class EvaluationPageView extends StatefulWidget {
  EvaluationPageView(int id);

  @override
  _EvaluationPageViewState createState() => _EvaluationPageViewState();
}

class _EvaluationPageViewState extends State<EvaluationPageView>
    with TickerProviderStateMixin {
  int _evaluationId; // TODO: send id to get evaluation question
  Future<List> _evaluationContent = Future<List>.delayed(
    Duration(seconds: 2),
    () => ConstantData.testEvaluation,
  );
  List<String> answers = new List<String>();
  String _selected;
  @override
  void initState() {
    super.initState();
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
              (alternative) => RadioListTile<String>(
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
              child: Text(
                question.body,
                style: TextStyle(fontSize: 16),
              ),
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
              child: Text(question.body),
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

  Widget renderQuestion(question) {
    if (question.type == "radio") {
      return radioQuestion(question);
    } else if (question.type == "inputText") {
      return inputTextQuestion(question);
    }
    return onlyTextQuestion(question);
  }

  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          _evaluationContent, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Widget> questions = new List<Widget>();
          for (var i = 0; i < snapshot.data.length; i++) {
            var question = Question.fromJson(snapshot.data[i]);
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
