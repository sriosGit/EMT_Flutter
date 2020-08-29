import 'package:SoyVidaApp/components/activityCard.dart';
import 'package:SoyVidaApp/models/Activity.dart';
import 'package:SoyVidaApp/screens/homeScreens/data.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  Future<List> _pendingActivities = Future<List>.delayed(
    Duration(seconds: 2),
    () => ConstantData.activities,
  );
  Future<List> _completedActivities = Future<List>.delayed(
    Duration(seconds: 2),
    () => ConstantData.activities,
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
              pendingActivities(),
              completedActivities(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pendingActivities() {
    return FutureBuilder(
      future:
          _pendingActivities, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Widget> tests = new List<Widget>();
          for (var i = 0; i < snapshot.data.length; i++) {
            var activity = Activity.fromJson(snapshot.data[i]);
            tests.add(new ActivityCard(activity));
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

  Widget completedActivities() {
    return FutureBuilder(
      future:
          _completedActivities, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Widget> activities = new List<Widget>();
          for (var i = 0; i < snapshot.data.length; i++) {
            var activity = Activity.fromJson(snapshot.data[i]);
            activities.add(new ActivityCard(activity));
          }
          children = activities;
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
