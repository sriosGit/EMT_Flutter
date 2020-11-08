import 'dart:io';

import 'package:EMT/screens/homeScreens/activitiesScreen.dart';
import 'package:EMT/screens/homeScreens/profileScreen.dart';
import 'package:EMT/screens/notificationsScreen.dart';
import 'package:EMT/screens/homeScreens/appointmentsScreen.dart';
import 'package:EMT/screens/homeScreens/askHelpScreen.dart';
import 'package:EMT/screens/homeScreens/evaluationsScreen.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  final int goto;

  const HomeScreen({Key key, this.goto = -1}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final List<Widget> _children = [
    AskHelpScreen(),
    EvaluationsScreen(),
    AppointmentsScreen(),
    ActivitiesScreen(),
    ProfileScreen()
  ];
  final List<String> _appbarTitles = [
    "Solicitar Ayuda",
    "Mis Evaluaciones",
    "Mis Citas",
    "Mis Actividades",
    "Mi Perfil"
  ];
  @override
  void initState() {
    super.initState();
    if (widget.goto >= 0) {
      setState(() => {_currentIndex = widget.goto});
    }
    firebaseCloudMessagingListeners();
  }

  void firebaseCloudMessagingListeners() {
    String uid;
    _firebaseMessaging.getToken().then((fcmToken) {
      SessionDBUtil.db.getAllSessions().then((session) {
        uid = session.first.idEstudiante.toString();
        if (fcmToken != null) {
          var userRecord = _db.collection('users').doc(uid);
          userRecord.set({
            'userId': uid,
            'deviceToken': fcmToken,
            'createdAt': FieldValue.serverTimestamp(), // optional
            'platform': Platform.operatingSystem // optional
          });
        }
      });
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_appbarTitles[_currentIndex]),
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.bell),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NotificationsScreen()));
              },
            ),
          ],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped, // new
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.commentAlt),
              label: 'Ayuda',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.clipboardCheck),
              label: 'Evaluacion',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendarAlt),
              label: 'Citas',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heartbeat),
              label: 'Actividades',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userAlt),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
