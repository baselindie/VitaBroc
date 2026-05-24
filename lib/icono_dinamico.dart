import 'package:flutter/services.dart';

class ServicioIconoDinamico {
  static const _channel = MethodChannel('com.example.vitabroc/icono');

  static Future<void> actualizarSegunRacha(int racha) async {
    String estado;
    if (racha >= 3) {
      estado = 'feliz';
    } else if (racha == 1 || racha == 2) {
      estado = 'normal';
    } else {
      estado = 'triste';
    }
    await cambiarIcono(estado);
  }

  static Future<void> cambiarIcono(String estado) async {
    try {
      final String alias;
      switch (estado) {
        case 'feliz':
          alias = 'com.example.vitabroc.MainActivityFeliz';
          break;
        case 'normal':
          alias = 'com.example.vitabroc.MainActivityNormal';
          break;
        case 'triste':
        default:
          alias = 'com.example.vitabroc.MainActivityTriste';
          break;
      }
      await _channel.invokeMethod('cambiarIcono', {'alias': alias});
    } catch (e) {
      // Si no funciona en este dispositivo, ignoramos
    }
  }
}