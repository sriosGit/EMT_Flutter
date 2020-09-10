import 'package:EMT/screens/homeScreens/activitiesScreen.dart';
import 'package:EMT/screens/homeScreens/profileScreen.dart';
import 'package:EMT/screens/notificationsScreen.dart';
import 'package:EMT/screens/homeScreens/appointmentsScreen.dart';
import 'package:EMT/screens/homeScreens/askHelpScreen.dart';
import 'package:EMT/screens/homeScreens/evaluationsScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
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
              title: new Text('Ayuda'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.clipboardCheck),
              title: new Text('Evaluacion'),
            ),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.calendarAlt),
                title: Text('Citas')),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heartbeat),
              title: new Text('Actividades'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userAlt),
              title: new Text('Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
