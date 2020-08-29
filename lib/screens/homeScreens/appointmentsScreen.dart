import 'package:SoyVidaApp/components/appointmentCard.dart';
import 'package:SoyVidaApp/models/Appointment.dart';
import 'package:SoyVidaApp/screens/homeScreens/data.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  Future<List> _pendingAppointments = Future<List>.delayed(
    Duration(seconds: 2),
    () => ConstantData.pendingAppointments,
  );
  DateTime startDate = DateTime(2020);
  DateTime endDate = DateTime(2025);
  _selectDate(BuildContext context, isStartDate) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != DateTime.now()) {
      if (isStartDate) {
        setState(() {
          startDate = picked;
        });
      } else {
        setState(() {
          endDate = picked;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pendingAppointments(),
      ),
    );
  }

  Widget dateRangePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(
          onPressed: () => _selectDate(context, true),
          child: Row(
            children: [
              Text('Fecha inicio: '),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    startDate.toLocal().toString().split(' ')[0],
                  ),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () => _selectDate(context, false),
          child: Row(
            children: [
              Text('Fecha fin: '),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    endDate.toLocal().toString().split(' ')[0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget pendingAppointments() {
    return FutureBuilder(
      future:
          _pendingAppointments, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Widget> appointments = new List<Widget>();
          for (var i = 0; i < snapshot.data.length; i++) {
            var appointment = Appointment.fromJson(snapshot.data[i]);
            appointments.add(new AppointmentCard(appointment));
          }
          children = appointments;
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
              dateRangePicker(),
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
