import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/foundation.dart';

class ServicioNotificaciones {
  static final FlutterLocalNotificationsPlugin _notificaciones =
      FlutterLocalNotificationsPlugin();

  static Future<void> inicializar() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notificaciones.initialize(settings);
  }

    static Future<void> programarRecordatorioDiario() async {
      try {
        await _notificaciones.zonedSchedule(
          0,
          '🥦 VitaBroc',
          'Hora de consumir tu suplemento funcional',
          _proximaOcho(),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'vitabroc_canal',
              'Recordatorios VitaBroc',
              channelDescription: 'Recordatorio diario de consumo',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      } catch (e) {
        // Si no tiene permiso de alarma exacta, ignoramos
        debugPrint('Notificación no programada: $e');
      }
    }

  static tz.TZDateTime _proximaOcho() {
    final tz.TZDateTime ahora = tz.TZDateTime.now(tz.local);
    tz.TZDateTime resultado = tz.TZDateTime(
      tz.local,
      ahora.year,
      ahora.month,
      ahora.day,
      8,
      0,
    );
    if (resultado.isBefore(ahora)) {
      resultado = resultado.add(const Duration(days: 1));
    }
    return resultado;
  }

  static Future<void> cancelarTodas() async {
    await _notificaciones.cancelAll();
  }
}
