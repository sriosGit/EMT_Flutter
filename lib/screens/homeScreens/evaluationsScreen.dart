import 'package:EMT/components/evaluationCard.dart';
import 'package:EMT/models/Evaluation.dart';
import 'package:EMT/services/homeService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class EvaluationsScreen extends StatefulWidget {
  @override
  _EvaluationsScreenState createState() => _EvaluationsScreenState();
}

class _EvaluationsScreenState extends State<EvaluationsScreen> {
  Future<dynamic> _pendingEvaluations;
  Future<dynamic> _completedEvaluations;
  @override
  void initState() {
    super.initState();
    SessionDBUtil.db.getAllSessions().then((session) => {
          setState(() => {
                _pendingEvaluations = fetchEvaluations(
                    session.first.idEstudiante, session.first.token, 1),
                _completedEvaluations = fetchEvaluations(
                    session.first.idEstudiante, session.first.token, 2),
              })
        });
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
              pendingEvaluations(),
              completedTests(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderNoResults() {
    return (Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Text("No se encontraron evaluaciones"),
    ));
  }

  Widget pendingEvaluations() {
    return FutureBuilder(
      future:
          _pendingEvaluations, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          print('wtf:' + snapshot.data.toString());
          if (snapshot.data.length <= 0) {
            children.add(renderNoResults());
          } else {
            List<Widget> evaluations = new List<Widget>();
            for (var i = 0; i < snapshot.data.length; i++) {
              var activity = Evaluation.fromJson(snapshot.data[i]);
              evaluations.add(new EvaluationCard(activity));
              children = evaluations;
            }
            children = evaluations;
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
        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        );
      },
    );
  }

  Widget completedTests() {
    return FutureBuilder(
      future:
          _completedEvaluations, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          if (snapshot.data is String) {
            children.add(renderNoResults());
          } else {
            List<Widget> evaluations = new List<Widget>();
            for (var i = 0; i < snapshot.data.length; i++) {
              var activity = Evaluation.fromJson(snapshot.data[i]);
              evaluations.add(new EvaluationCard(activity));
              children = evaluations;
            }
            children = evaluations;
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
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            )
          ];
        }
        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
