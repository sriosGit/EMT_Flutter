class ConstantData {
  static const pendingEvaluations = [
    {
      "id": 0,
      "status": "pending",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "tutorName": "Pedro Aranda"
    },
    {
      "id": 1,
      "status": "pending",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "tutorName": "Pedro Aranda"
    },
    {
      "id": 2,
      "status": "pending",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "tutorName": "Pedro Aranda"
    },
  ];
  static const completedEvaluations = [
    {
      "id": 3,
      "status": "completed",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "tutorName": "Pedro Aranda"
    },
    {
      "id": 4,
      "status": "completed",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "tutorName": "Pedro Aranda"
    },
    {
      "id": 5,
      "status": "completed",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "tutorName": "Pedro Aranda"
    },
  ];
  static const pendingAppointments = [
    {
      "id": 3,
      "status": "pending",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "area": "Relaciones Interpersonales"
    },
    {
      "id": 4,
      "status": "completed",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "area": "Relaciones Interpersonales"
    },
    {
      "id": 5,
      "status": "completed",
      "description": "Prueba psicológica",
      "date": "19/07/2020",
      "area": "Relaciones Interpersonales"
    },
  ];
  static const testEvaluation = [
    {
      "type": "onlyText",
      "title": "Bienvenido a la evaluación",
      "body":
          "Instrucciones: Este cuestionario consta de 21 afirmaciones. Por favor, lea con atención cada uno de ellos cuidadosamente. Luego eliga uno de cada grupo, en el mejor de los casos, el que mejor describa el modo como se ha sentido en las ultimas dos semanas, incluyendo el dia de hoy. Seleccione el numero correspondiente al enunciado elegido. Si varios enunciados de un mismo grupo le parecen igualmente apropiados, marque el numero más alto. Verifique que no haya elegido más de uno por grupo.",
    },
    {
      "type": "radio",
      "title": "Tristeza",
      "body":
          "Este es un texto de prueba, se puede cambiar en cualquier momento.",
      "alternatives": [
        {
          "description": "No me siento triste",
          "value": "1",
        },
        {
          "description": "Me siento triste gran parte del tiempo",
          "value": "2",
        },
        {
          "description": "Me siento triste todo el tiempo",
          "value": "3",
        },
        {
          "description":
              "Me siento tan triste o soy tan infeliz que no puedo soportarlo",
          "value": "4",
        },
      ],
    },
    {
      "type": "inputText",
      "title": "Cuentanos algo:",
      "body":
          "Este es un texto de prueba, se puede cambiar en cualquier momento.",
      "btnText": "Finalizar",
    }
  ];
  static const notifications = [
    {
      "title": "Nueva Evaluación pendiente",
      "description": "Hola Sergio! Tienes una evaluación pendiente",
      "date": "Hace 10 minutos",
    },
    {
      "title": "Nuevas actividades",
      "description": "Hola Sergio! Tienes nuevas actividades por realizar",
      "date": "Hace 2 horas",
    },
    {
      "title": "Tu cita ha sido programada",
      "description": "Hola Sergio! Tu cita ha sido programada para el Martes",
      "date": "Hace 1 día",
    },
  ];
  static const activities = [
    {
      "action": "Conversar 5 veces con un amigo o familiar por celular",
    },
    {
      "action": "Realizar ejercicio por 10 minutos",
    }
  ];
  static const currentUser = {
    "firstName": "Sergio Alejandro",
    "lastName": "Rios Caballero",
    "schoolName": "I.E. Sarita Colonia",
    "section": "B",
    "tutor": "Juan Marquez",
    "email": "srioscab@correo.com",
    "picture": "/assets/images/profile-pic.JPG"
  };
}
