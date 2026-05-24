import 'package:flutter/material.dart';
import '../exportar_csv.dart';

class PantallaPanelProfesor extends StatefulWidget {
  const PantallaPanelProfesor({super.key});

  @override
  State<PantallaPanelProfesor> createState() => _PantallaPanelProfesorState();
}

class _PantallaPanelProfesorState extends State<PantallaPanelProfesor> {
  final _contrasenaController = TextEditingController();
  bool _autenticado = false;
  bool _errorContrasena = false;
  static const String _contrasena = '1234';

  void _verificarContrasena() {
    if (_contrasenaController.text == _contrasena) {
      setState(() {
        _autenticado = true;
        _errorContrasena = false;
      });
    } else {
      setState(() => _errorContrasena = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          'Panel del Profesor',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: _autenticado
            ? _PanelDatos()
            : _PantallaLogin(
                controller: _contrasenaController,
                error: _errorContrasena,
                onVerificar: _verificarContrasena,
              ),
      ),
    );
  }
}

class _PantallaLogin extends StatelessWidget {
  final TextEditingController controller;
  final bool error;
  final VoidCallback onVerificar;

  const _PantallaLogin({
    required this.controller,
    required this.error,
    required this.onVerificar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔒', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 24),
          const Text(
            'Acceso restringido',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ingresa la contraseña del profesor',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF4CAF50), width: 2),
              ),
              errorText: error ? 'Contraseña incorrecta' : null,
              prefixIcon: const Icon(Icons.lock, color: Color(0xFF4CAF50)),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onVerificar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen del estudio',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _TarjetaResumen(
                  emoji: '👥',
                  titulo: 'Participantes',
                  valor: '24',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TarjetaResumen(
                  emoji: '📋',
                  titulo: 'Registros hoy',
                  valor: '18',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _TarjetaResumen(
                  emoji: '✅',
                  titulo: 'Consumo hoy',
                  valor: '75%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TarjetaResumen(
                  emoji: '😊',
                  titulo: 'Aceptación',
                  valor: '82%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                try {
                  await ServicioExportarCSV.exportar();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('❌ Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.download),
              label: const Text(
                'Exportar CSV',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Participantes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                _FilaParticipante(
                    nombre: 'Participante 1',
                    perfil: 'Niño',
                    racha: 5,
                    consumioHoy: true),
                _FilaParticipante(
                    nombre: 'Participante 2',
                    perfil: 'Adulto mayor',
                    racha: 3,
                    consumioHoy: false),
                _FilaParticipante(
                    nombre: 'Participante 3',
                    perfil: 'Niño',
                    racha: 7,
                    consumioHoy: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaResumen extends StatelessWidget {
  final String emoji;
  final String titulo;
  final String valor;

  const _TarjetaResumen({
    required this.emoji,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          Text(
            titulo,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _FilaParticipante extends StatelessWidget {
  final String nombre;
  final String perfil;
  final int racha;
  final bool consumioHoy;

  const _FilaParticipante({
    required this.nombre,
    required this.perfil,
    required this.racha,
    required this.consumioHoy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            consumioHoy ? '😊' : '😠',
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  perfil,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            '🔥 $racha días',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFFFF6F00),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
