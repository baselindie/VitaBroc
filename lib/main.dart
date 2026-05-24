import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notificaciones.dart';
import 'pantallas/bienvenida.dart';
import 'pantallas/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ServicioNotificaciones.inicializar();
  await ServicioNotificaciones.programarRecordatorioDiario();

  final prefs = await SharedPreferences.getInstance();
  final yaAcepto = prefs.getBool('acepto_terminos') ?? false;

  runApp(VitaBroc(yaAcepto: yaAcepto));
}

class VitaBroc extends StatelessWidget {
  final bool yaAcepto;
  const VitaBroc({super.key, required this.yaAcepto});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitaBroc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF50)),
        useMaterial3: true,
      ),
      home: yaAcepto ? const PantallaHome() : const PantallaBienvenida(),
    );
  }
}
