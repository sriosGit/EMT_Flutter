import 'package:EMT/models/PushedNotification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationCard extends StatelessWidget {
  final PushedNotification notification;

  NotificationCard(this.notification);

  _onTapCard(BuildContext context) async {
    return print("TODO: goto notifications");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {_onTapCard(context)},
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            notification.description,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            notification.date,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[600]),
                          ),
                        ]),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
