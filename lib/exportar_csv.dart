import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ServicioExportarCSV {
  static Future<void> exportar() async {
    try {
      final registros = await FirebaseFirestore.instance
          .collection('registros')
          .orderBy('timestamp', descending: false)
          .get();

      if (registros.docs.isEmpty) {
        throw Exception('No hay registros para exportar');
      }

      // Cabecera del CSV
      String csv =
          'userId,fecha,consumio,comoSeSiente,leAgradoElSabor,loConsumiriaOtraVez\n';

      // Filas
      for (final doc in registros.docs) {
        final data = doc.data();
        final userId = data['userId'] ?? '';
        final fecha = data['fecha'] ?? '';
        final consumio = data['consumio'] == true ? 'Sí' : 'No';
        final comoSeSiente = data['comoSeSiente']?.toString() ?? '';
        final sabor = data['leAgradoElSabor']?.toString() ?? '';
        final otraVez = data['loConsumiriaOtraVez']?.toString() ?? '';

        csv += '$userId,$fecha,$consumio,$comoSeSiente,$sabor,$otraVez\n';
      }

      // Guardar archivo temporal
      final directorio = await getTemporaryDirectory();
      final archivo = File('${directorio.path}/vitabroc_registros.csv');
      await archivo.writeAsString(csv);

      // Compartir
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(archivo.path)],
          subject: 'Registros VitaBroc',
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
