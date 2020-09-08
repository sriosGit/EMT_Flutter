import 'package:EMT/models/Appointment.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  AppointmentCard(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 90,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fecha de cita:',
                            ),
                            Text(
                              appointment.date,
                            ),
                          ],
                        ),
                        renderStatus(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Area:',
                              ),
                              Text(
                                appointment.area,
                              ),
                            ]),
                      ]),
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                color: Colors.blue,
                child: Text(
                  'Ver más',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => {},
              ),
            ]),
      ),
    );
  }

  Widget renderStatus() {
    if (appointment.status == 'pending') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Estado:',
          ),
          Text(
            'PENDIENTE',
            style: TextStyle(color: Colors.red),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Estado:',
        ),
        Text(
          'COMPLETADO',
          style: TextStyle(color: Colors.green[700]),
        ),
      ],
    );
  }
}
