import 'package:flutter/material.dart';
import 'consentimiento.dart';

class PantallaSeleccionPerfil extends StatelessWidget {
  const PantallaSeleccionPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text('🥦', style: TextStyle(fontSize: 60)),
              const SizedBox(height: 16),
              const Text(
                '¿Quién eres?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecciona tu perfil para continuar',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 48),
              _TarjetaPerfil(
                emoji: '👦',
                titulo: 'Niño',
                descripcion: 'Soy un participante joven',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PantallaConsentimiento(),
                      ));
                },
              ),
              const SizedBox(height: 16),
              _TarjetaPerfil(
                emoji: '👴',
                titulo: 'Adulto mayor',
                descripcion: 'Soy un participante adulto',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PantallaConsentimiento(),
                      ));
                },
              ),
              const SizedBox(height: 16),
              _TarjetaPerfil(
                emoji: '👨‍👧',
                titulo: 'Familiar responsable',
                descripcion: 'Registro en nombre de alguien',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PantallaConsentimiento(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TarjetaPerfil extends StatelessWidget {
  final String emoji;
  final String titulo;
  final String descripcion;
  final VoidCallback onTap;

  const _TarjetaPerfil({
    required this.emoji,
    required this.titulo,
    required this.descripcion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Text(
                  descripcion,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
