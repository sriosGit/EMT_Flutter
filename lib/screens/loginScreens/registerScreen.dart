import 'dart:async';

import 'package:EMT/screens/homeScreen.dart';
import 'package:EMT/services/authService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpForm extends StatefulWidget {
  final Function goToLogin;

  const SignUpForm({Key key, this.goToLogin}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<ScaffoldState> _scaffoldSignUpKey =
      new GlobalKey<ScaffoldState>();

  dynamic onSuccessFb(accessToken, graphResponse) {
    firstName1Controller.text = graphResponse["first_name"];
    lastName1Controller.text = graphResponse["last_name"];
    emailController.text = graphResponse["email"];
    setState(() {
      showCompleteData = true;
      fbToken = accessToken.token;
      fbUserId = accessToken.userId;
    });
    gotoEmailRegisterWith();
  }

  dynamic onErrorFb() {
    print("something is wrong");
  }

  String fbToken = "";
  String fbUserId = "";
  bool showCompleteData = false;
  bool loading = false;

  void _onClickRegister() {
    print("ON CLICK SIGNUP");
    _showLoaderDialog();
    setState(() => {loading = true});
    createUser(
      firstName1Controller.text,
      firstName2Controller.text,
      lastName1Controller.text,
      lastName2Controller.text,
      int.parse(phoneNumberController.text),
      emailController.text,
      signUpPasswordController.text,
      rePasswordController.text,
      int.parse(dniController.text),
      "Estudiante",
      fbToken,
      fbUserId,
      onSuccessSignup,
      onErrorSignup,
    );
  }

  Future<bool> onSuccessSignup(res) async {
    setState(() => {loading = false});
    if (res is String)
      _scaffoldSignUpKey.currentState.showSnackBar(SnackBar(
        content: new Text('Error: $res'),
        duration: new Duration(seconds: 10),
      ));
    else {
      _scaffoldSignUpKey.currentState.showSnackBar(SnackBar(
        content: new Text('Registro Exitoso'),
        duration: new Duration(seconds: 10),
      ));

      SessionDBUtil.db.deleteAllSession().then((deleted) => {
            SessionDBUtil.db.addSessionToDatabase(res).then(
                  (response) => {
                    Timer(
                      Duration(seconds: 2),
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ),
                      ),
                    ),
                  },
                ),
          });
    }
    return true;
  }

  bool onErrorSignup(res) {
    _scaffoldSignUpKey.currentState.showSnackBar(SnackBar(
      content: new Text('Error: $res'),
      duration: new Duration(seconds: 10),
    ));
    return true;
  }

  Future<void> _showLoaderDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100.0),
            Center(
                child: Text(
              "Crear una nueva cuenta",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 25.0,
              ),
            )),
            Center(
              child: Container(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 30.0),
                  child: Text(
                    "Somos una organización que busca que más personas accedan a servicios de salud mental",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 15.0,
                    ),
                  )),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 20.0, left: 20.0, right: 20.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0Xff3B5998),
                      onPressed: () =>
                          facebookLogin(onSuccessFb, onErrorFb, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.facebookF,
                              color: Colors.white, size: 20.0),
                          Text(
                            "Regístrate con Facebook",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 20.0, right: 20.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0Xffdb3236),
                      onPressed: googleLogin,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.googlePlusG,
                              color: Colors.white, size: 20.0),
                          Text(
                            "Regístrate con Google",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 20.0, right: 20.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      onPressed: () => gotoEmailRegisterWith(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.envelope,
                              color: Colors.grey, size: 20.0),
                          Text(
                            "Regístrate con tu correo",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
