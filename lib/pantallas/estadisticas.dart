import 'package:flutter/material.dart';

class PantallaEstadisticas extends StatelessWidget {
  const PantallaEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text(
          'Estadísticas',
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
              const Text(
                'Tu progreso',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 20),
              // Racha
              _TarjetaStat(
                emoji: '🔥',
                titulo: 'Racha actual',
                valor: '5 días',
                color: const Color(0xFFFF6F00),
              ),
              const SizedBox(height: 12),
              // Consumo semanal
              _TarjetaStat(
                emoji: '📅',
                titulo: 'Consumo semanal',
                valor: '5 de 7 días',
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(height: 12),
              // Frecuencia
              _TarjetaStat(
                emoji: '📊',
                titulo: 'Frecuencia',
                valor: '71%',
                color: const Color(0xFF1976D2),
              ),
              const SizedBox(height: 12),
              // Aceptación
              _TarjetaStat(
                emoji: '😊',
                titulo: 'Aceptación',
                valor: '80%',
                color: const Color(0xFF7B1FA2),
              ),
              const SizedBox(height: 24),
              // Consumo por día
              const Text(
                'Esta semana',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _DiaSemana(dia: 'L', consumio: true),
                    _DiaSemana(dia: 'M', consumio: true),
                    _DiaSemana(dia: 'X', consumio: false),
                    _DiaSemana(dia: 'J', consumio: true),
                    _DiaSemana(dia: 'V', consumio: true),
                    _DiaSemana(dia: 'S', consumio: true),
                    _DiaSemana(dia: 'D', consumio: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TarjetaStat extends StatelessWidget {
  final String emoji;
  final String titulo;
  final String valor;
  final Color color;

  const _TarjetaStat({
    required this.emoji,
    required this.titulo,
    required this.valor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 36)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                valor,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiaSemana extends StatelessWidget {
  final String dia;
  final bool consumio;

  const _DiaSemana({required this.dia, required this.consumio});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          consumio ? '😊' : '😠',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          dia,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: consumio ? const Color(0xFF4CAF50) : Colors.grey,
          ),
        ),
      ],
    );
  }
}