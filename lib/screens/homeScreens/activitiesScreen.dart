import 'package:EMT/components/activityCard.dart';
import 'package:EMT/models/Activity.dart';
import 'package:EMT/services/homeService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  Future<dynamic> _pendingActivities;
  Future<dynamic> _completedActivities;

  @override
  void initState() {
    super.initState();
    SessionDBUtil.db.getAllSessions().then((session) => {
          setState(() => {
                _pendingActivities = fetchActivities(
                    session.first.userId, session.first.token, 1),
                _completedActivities = fetchActivities(
                    session.first.userId, session.first.token, 2),
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
              pendingActivities(),
              completedActivities(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderNoResults(String message) {
    return (Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Text(message),
    ));
  }

  Widget pendingActivities() {
    return FutureBuilder(
      future:
          _pendingActivities, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          if (snapshot.data is String) {
            children.add(renderNoResults(snapshot.data));
          } else {
            List<Widget> activities = new List<Widget>();
            for (var i = 0; i < snapshot.data.length; i++) {
              var activity = Activity.fromJson(snapshot.data[i]);
              activities.add(new ActivityCard(activity));
              children = activities;
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

  Widget completedActivities() {
    return FutureBuilder(
      future:
          _completedActivities, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          if (snapshot.data is String) {
            children.add(renderNoResults(snapshot.data));
          } else {
            List<Widget> activities = new List<Widget>();
            for (var i = 0; i < snapshot.data.length; i++) {
              var activity = Activity.fromJson(snapshot.data[i]);
              activities.add(new ActivityCard(activity));
              children = activities;
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
