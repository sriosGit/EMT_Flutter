import 'package:EMT/models/JournalEntry.dart';
import 'package:flutter/material.dart';

class JournalEntryCard extends StatelessWidget {
  final JournalEntry journalEntry;

  JournalEntryCard(this.journalEntry);

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
                            journalEntry.texto,
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
