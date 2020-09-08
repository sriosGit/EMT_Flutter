import 'package:EMT/components/infoCard.dart';
import 'package:EMT/models/User.dart';
import 'package:EMT/screens/homeScreens/data.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /*
  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }
  */

  static User user = User.fromJson(ConstantData.currentUser);
  static String name = user.firstName + ' ' + user.lastName;
  @override
  Widget build(BuildContext context) {
    print(name);
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
              /*
              onPressed: () async {
                String removeSpaceFromPhoneNumber =
                    phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
               final phoneCall = 'tel:$removeSpaceFromPhoneNumber';
                
                if (await launcher.canLaunch(phoneCall)) {
                  await launcher.launch(phoneCall);
                } else {
                  _showDialog(
                    context,
                    title: 'Sorry',
                    msg: 'please try again ',
                  );
                }*/
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
              /*
              onPressed: () async {
                final emailAddress = 'mailto:$email';
                if (await launcher.canLaunch(emailAddress)) {
                  await launcher.launch(emailAddress);
                } else {
                  _showDialog(
                    context,
                    title: 'Sorry',
                    msg: 'please try again ',
                  );
                }
              },
              */
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
