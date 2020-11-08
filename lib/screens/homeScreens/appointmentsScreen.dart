import 'package:EMT/components/appointmentCard.dart';
import 'package:EMT/models/Appointment.dart';
import 'package:EMT/services/homeService.dart';
import 'package:EMT/utils/sessionDBUtil.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  Future<dynamic> _pendingAppointments;
  Future<dynamic> _completedAppointments;

  DateTime startDate = DateTime(2020);
  DateTime endDate = DateTime(2025);
  @override
  void initState() {
    super.initState();
    SessionDBUtil.db.getAllSessions().then(
          (session) => {
            setState(() => {
                  _pendingAppointments = fetchAppointments(
                      session.first.idEstudiante, session.first.token, 1),
                  _completedAppointments = fetchAppointments(
                      session.first.idEstudiante, session.first.token, 2),
                })
          },
        );
  }

  Future<void> _showAppointmentDetails(appointment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles de la cita'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nombre: ${appointment.nombre}'),
                SizedBox(height: 20),
                Text('Descripcion: ${appointment.descripcion}'),
                SizedBox(height: 20),
                Text('Especialista: ${appointment.primerNOmbre}'),
                SizedBox(height: 20),
                Text(
                    'Fecha programada: ${appointment.fechaInicio.split(" ")[0]}'),
                SizedBox(height: 20),
                Text(
                    'Hora: ${appointment.fechaInicio.split(" ")[1].substring(0, 5)}'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cerrar',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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

  Widget renderNoResults(String message) {
    return (Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              height: 50.0,
              child: new TabBar(
                tabs: [
                  Text(
                    "Pendientes",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    "Realizadas",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              pendingAppointments(),
              completedAppointments(),
            ],
          ),
        ),
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
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          if (snapshot.data is String) {
            children.add(renderNoResults(snapshot.data));
          } else {
            List<Widget> appointments = new List<Widget>();
            for (var i = 0; i < snapshot.data.length; i++) {
              var activity = Appointment.fromJson(snapshot.data[i]);
              appointments
                  .add(new AppointmentCard(activity, _showAppointmentDetails));
              children = appointments;
            }
          }
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

  Widget completedAppointments() {
    return FutureBuilder(
      future:
          _completedAppointments, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          if (snapshot.data is String) {
            children.add(renderNoResults(snapshot.data));
          } else {
            List<Widget> appointments = new List<Widget>();
            for (var i = 0; i < snapshot.data.length; i++) {
              var activity = Appointment.fromJson(snapshot.data[i]);
              appointments
                  .add(new AppointmentCard(activity, _showAppointmentDetails));
              children = appointments;
            }
          }
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
