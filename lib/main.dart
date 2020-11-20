import 'package:EMT/screens/loginScreen.dart';
import 'package:call_log/call_log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

var callLogs;

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    // CallLog.query(
    //  dateFrom: from,
    //  dateTo: to,
    //).then((callLogEntries) {
    print(callLogs);
    // });
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  bool _initialized = false;
  bool _error = false;

  Map<String, dynamic> _convertCallLogsToMap(entry) {
    Map<String, dynamic> map = {};
    map['formattedNumber'] = entry.formattedNumber;
    map['cachedMatchedNumber'] = entry.cachedMatchedNumber;
    map['number'] = entry.number;
    map['name'] = entry.name;
    map['callType'] = entry.callType;
    map['cachedMatchedNumber'] =
        DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
    map['duration'] = entry.duration;
    print(map);
    return map;
  }

  @override
  void initState() {
    var now = DateTime.now();
    int from = now.subtract(Duration(days: 7)).millisecondsSinceEpoch;
    int to = now.millisecondsSinceEpoch;

    CallLog.query(
      dateFrom: from,
      dateTo: to,
    ).then((callLogEntries) {
      callLogs = callLogEntries.map((e) => _convertCallLogsToMap(e)).toList();
      Workmanager.registerPeriodicTask(
        "23",
        "notSoSimplePeriodicTask23",
        // When no frequency is provided the default 15 minutes is set.
        // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
      ); //Android only (see below)
    });
    super.initState();
  }

  void initializeFlutterFire() async {
    print("Hello World, I'm EMT");
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*
    if(_error) {
      return SomethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }
    */
    return MaterialApp(
      title: 'MET',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(
        child: LoginScreen3(),
      ),
    );
  }
}
