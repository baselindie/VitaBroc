import 'package:cloud_firestore/cloud_firestore.dart';

class ServicioRacha {
  static Future<int> obtenerRacha(String userId) async {
    final hoy = DateTime.now();

    final registros = await FirebaseFirestore.instance
        .collection('registros')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    if (registros.docs.isEmpty) return 0;

    int racha = 0;
    DateTime fechaActual = hoy;

    for (final doc in registros.docs) {
      final fecha = DateTime.parse(doc['fecha']);
      final diferencia = fechaActual
          .difference(DateTime(fecha.year, fecha.month, fecha.day))
          .inDays;

      if (diferencia == 0 || diferencia == 1) {
        racha++;
        fechaActual = DateTime(fecha.year, fecha.month, fecha.day);
      } else {
        break;
      }
    }

    return racha;
  }

  static Future<bool> yaRegistroHoy(String userId) async {
    final hoy = DateTime.now();
    final inicioHoy = DateTime(hoy.year, hoy.month, hoy.day);
    final finHoy = inicioHoy.add(const Duration(days: 1));

    final registros = await FirebaseFirestore.instance
        .collection('registros')
        .where('userId', isEqualTo: userId)
        .where('timestamp', isGreaterThanOrEqualTo: inicioHoy)
        .where('timestamp', isLessThan: finHoy)
        .get();

    return registros.docs.isNotEmpty;
  }
}
