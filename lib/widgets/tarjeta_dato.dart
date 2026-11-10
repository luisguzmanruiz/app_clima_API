
import 'package:flutter/material.dart';

class TarjetaDato extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;

  const TarjetaDato({
    super.key,
    required this.icono,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icono,
            color: Colors.blue,
            size: 32,
          ),

          const SizedBox(height: 10),

          Text(
            titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            valor,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
