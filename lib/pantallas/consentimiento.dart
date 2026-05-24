import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class PantallaConsentimiento extends StatefulWidget {
  const PantallaConsentimiento({super.key});

  @override
  State<PantallaConsentimiento> createState() => _PantallaConsentimientoState();
}

class _PantallaConsentimientoState extends State<PantallaConsentimiento> {
  bool _aceptado = false;

  Future<void> _continuar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('acepto_terminos', true);
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHome()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text(
          'Consentimiento',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('🥦', style: TextStyle(fontSize: 50)),
                      const SizedBox(height: 16),
                      const Text(
                        'Consentimiento Informado',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Este estudio investiga los efectos del consumo de gomitas de extracto de brócoli en el bienestar de los participantes.\n\n'
                        'Al participar, usted acepta:\n\n'
                        '• Registrar diariamente el consumo del suplemento.\n\n'
                        '• Responder preguntas sobre su bienestar general.\n\n'
                        '• Que los datos recopilados serán utilizados únicamente con fines académicos.\n\n'
                        '• Que su participación es voluntaria y puede retirarse en cualquier momento.\n\n'
                        'Los datos serán tratados de forma confidencial.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _aceptado,
                    activeColor: const Color(0xFF4CAF50),
                    onChanged: (valor) {
                      setState(() {
                        _aceptado = valor ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'He leído y acepto los términos de participación',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _aceptado ? _continuar : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
