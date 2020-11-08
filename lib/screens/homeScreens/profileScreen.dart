import 'package:EMT/components/editProfileForm.dart';
import 'package:EMT/components/infoCard.dart';
import 'package:EMT/models/User.dart';
import 'package:EMT/screens/loginScreen.dart';
import 'package:EMT/services/homeService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<dynamic> _fetchProfile;
  @override
  void initState() {
    super.initState();
    SessionDBUtil.db.getAllSessions().then((session) => {
          setState(() => {
                _fetchProfile = fetchProfile(
                    session.first.idEstudiante, session.first.token),
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: renderProfile(),
        ),
      ),
    );
  }

  void deleteSession() {
    SessionDBUtil.db.deleteAllSession().then(
          (deleted) => {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen3())),
          },
        );
  }

  Widget renderProfile() {
    return FutureBuilder(
      future: _fetchProfile, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          User user = User.fromJson(snapshot.data);
          children = <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage:
                          AssetImage("assets/images/profile-pic.JPG"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                          child: Text(
                            "Editar",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditProfileForm(
                                        user: user,
                                      ),
                                    ))
                              })
                    ],
                  ),
                  InfoCard(
                    text: user.firstName,
                    icon: Icons.account_circle,
                  ),
                  InfoCard(
                    text: user.lastName,
                    icon: Icons.account_circle,
                  ),
                  InfoCard(
                    text: user.celularEstudiante.toString(),
                    icon: Icons.phone,
                  ),
                  InfoCard(
                    text: user.email,
                    icon: Icons.email,
                  ),
                  /*
                  InfoCard(
                    text: user.colegio,
                    icon: Icons.school,
                  ),
                  */
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          child: Text(
                            "Cerrar sesión",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () => deleteSession()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ];
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
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              )
            ],
          ),
        );
      },
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage("assets/images/profile-pic.JPG"),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            InfoCard(
              text: user.schoolName,
              icon: Icons.school,
            ),
            InfoCard(
              text: 'Sección ' + user.section,
              icon: Icons.school,
            ),
            InfoCard(
              text: user.tutor,
              icon: Icons.perm_identity,
            ),
            InfoCard(
              text: user.email,
              icon: Icons.email,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
    */
