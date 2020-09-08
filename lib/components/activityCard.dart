import 'package:EMT/models/Activity.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  ActivityCard(this.activity);

  _onTapCard(BuildContext context) async {
    return print("TODO: goto activity details");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {_onTapCard(context)},
      child: Card(
        child: Container(
          height: 60,
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
                            activity.action,
                            style: TextStyle(fontSize: 16),
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
