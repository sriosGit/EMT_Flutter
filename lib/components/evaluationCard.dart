import 'package:EMT/components/evaluationPageView.dart';
import 'package:EMT/models/Evaluation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EvaluationCard extends StatelessWidget {
  final Evaluation evaluation;

  EvaluationCard(this.evaluation);

  _onTapCard(BuildContext context) async {
    if (evaluation.status == "PENDIENTE") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => EvaluationPageView(
              userId: evaluation.idEstudiante,
              evaluationId: evaluation.id,
              evaluationObjId: evaluation.idObjetoEvaluacion),
        ),
      );
    } else if (evaluation.status == "FINALIZADO") {
      print("TODO: Mostrar detalle");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {_onTapCard(context)},
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 90,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                renderActivityLeftIcon(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            evaluation.description,
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Asignado: ' + evaluation.date,
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Tutor: ' + evaluation.tutorName,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ]),
                        ]),
                  ),
                ),
                FaIcon(FontAwesomeIcons.angleRight,
                    color: Colors.blueGrey[900], size: 20.0),
              ]),
        ),
      ),
    );
  }

  Widget renderActivityLeftIcon() {
    if (evaluation.status == "completed") {
      return FaIcon(FontAwesomeIcons.clipboardCheck,
          color: Colors.blueGrey[900], size: 50.0);
    }
    return FaIcon(FontAwesomeIcons.clipboardList,
        color: Colors.blueGrey[900], size: 50.0);
  }
}
