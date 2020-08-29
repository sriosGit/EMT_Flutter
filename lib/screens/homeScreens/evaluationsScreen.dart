import 'package:SoyVidaApp/components/evaluationCard.dart';
import 'package:SoyVidaApp/models/Evaluation.dart';
import 'package:SoyVidaApp/screens/homeScreens/data.dart';
import 'package:flutter/material.dart';

class EvaluationsScreen extends StatefulWidget {
  @override
  _EvaluationsScreenState createState() => _EvaluationsScreenState();
}

class _EvaluationsScreenState extends State<EvaluationsScreen> {
  Future<List> _pendingTests = Future<List>.delayed(
    Duration(seconds: 2),
    () => ConstantData.pendingEvaluations,
  );
  Future<List> _completedTests = Future<List>.delayed(
    Duration(seconds: 2),
    () => ConstantData.pendingEvaluations,
  );
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
                    "Pendientes",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    "Realizadas",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              pendingTests(),
              completedTests(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pendingTests() {
    return FutureBuilder(
      future: _pendingTests, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Widget> tests = new List<Widget>();
          for (var i = 0; i < snapshot.data.length; i++) {
            var evaluation = Evaluation.fromJson(snapshot.data[i]);
            tests.add(new EvaluationCard(evaluation));
          }
          children = tests;
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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  Widget completedTests() {
    return FutureBuilder(
      future: _completedTests, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Widget> tests = new List<Widget>();
          for (var i = 0; i < snapshot.data.length; i++) {
            var evaluation = Evaluation.fromJson(snapshot.data[i]);
            tests.add(new EvaluationCard(evaluation));
          }
          children = tests;
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
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
