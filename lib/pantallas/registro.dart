import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  bool? _consumio;
  int? _comoSeSiente;
  int? _leAgradoElSabor;
  int? _loConsumiriaOtraVez;

  Future<void> _guardarRegistro() async {
    try {
      await FirebaseFirestore.instance.collection('registros').add({
  'consumio': _consumio,
  'comoSeSiente': _comoSeSiente,
  'leAgradoElSabor': _leAgradoElSabor,
  'loConsumiriaOtraVez': _loConsumiriaOtraVez,
  'fecha': DateTime.now().toIso8601String(),
  'timestamp': FieldValue.serverTimestamp(),
  'userId': 'temporal', // se cambiará cuando implementemos QR/link
});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Registro guardado'),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Error al guardar'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  bool _puedeGuardar() {
    return _consumio != null &&
        _comoSeSiente != null &&
        _leAgradoElSabor != null &&
        _loConsumiriaOtraVez != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text(
          'Registro del día',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      '¿Consumiste tu suplemento hoy?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _BotonCarita(
                          emoji: '😊',
                          label: 'Sí',
                          seleccionado: _consumio == true,
                          onTap: () => setState(() => _consumio = true),
                        ),
                        _BotonCarita(
                          emoji: '😠',
                          label: 'No',
                          seleccionado: _consumio == false,
                          onTap: () => setState(() => _consumio = false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bienestar percibido',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 12),
              _PreguntaBienestar(
                pregunta: '¿Cómo te sientes hoy?',
                valor: _comoSeSiente,
                onChanged: (v) => setState(() => _comoSeSiente = v),
              ),
              const SizedBox(height: 12),
              _PreguntaBienestar(
                pregunta: '¿Te agradó el sabor?',
                valor: _leAgradoElSabor,
                onChanged: (v) => setState(() => _leAgradoElSabor = v),
              ),
              const SizedBox(height: 12),
              _PreguntaBienestar(
                pregunta: '¿Lo consumirías otra vez?',
                valor: _loConsumiriaOtraVez,
                onChanged: (v) => setState(() => _loConsumiriaOtraVez = v),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _puedeGuardar() ? _guardarRegistro : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Guardar registro',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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

class _BotonCarita extends StatelessWidget {
  final String emoji;
  final String label;
  final bool seleccionado;
  final VoidCallback onTap;

  const _BotonCarita({
    required this.emoji,
    required this.label,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: seleccionado
              ? const Color(0xFF4CAF50)
              : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: seleccionado
                ? const Color(0xFF4CAF50)
                : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: seleccionado ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreguntaBienestar extends StatelessWidget {
  final String pregunta;
  final int? valor;
  final Function(int) onChanged;

  const _PreguntaBienestar({
    required this.pregunta,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pregunta,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _OpcionEmoji(
                  emoji: '😢',
                  valor: 1,
                  seleccionado: valor == 1,
                  onTap: () => onChanged(1)),
              _OpcionEmoji(
                  emoji: '😐',
                  valor: 2,
                  seleccionado: valor == 2,
                  onTap: () => onChanged(2)),
              _OpcionEmoji(
                  emoji: '😊',
                  valor: 3,
                  seleccionado: valor == 3,
                  onTap: () => onChanged(3)),
              _OpcionEmoji(
                  emoji: '😄',
                  valor: 4,
                  seleccionado: valor == 4,
                  onTap: () => onChanged(4)),
            ],
          ),
        ],
      ),
    );
  }
}

class _OpcionEmoji extends StatelessWidget {
  final String emoji;
  final int valor;
  final bool seleccionado;
  final VoidCallback onTap;

  const _OpcionEmoji({
    required this.emoji,
    required this.valor,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: seleccionado
              ? const Color(0xFF4CAF50)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(emoji, style: const TextStyle(fontSize: 36)),
      ),
    );
  }
}