
import 'package:flutter/material.dart';

class Clima {
  final String ciudad;
  final double temperatura;
  final double sensacion;
  final int humedad;
  final double viento;
  final int codigo;

  Clima({
    required this.ciudad,
    required this.temperatura,
    required this.sensacion,
    required this.humedad,
    required this.viento,
    required this.codigo,
  });

  // CONVERTIR JSON A OBJETO CLIMA
  factory Clima.fromJson(
    Map<String, dynamic> json,
    String nombreCiudad,
  ) {
    return Clima(
      ciudad: nombreCiudad,
      temperatura:
          (json['temperature_2m'] as num).toDouble(),
      sensacion:
          (json['apparent_temperature'] as num).toDouble(),
      humedad:
          (json['relative_humidity_2m'] as num).toInt(),
      viento:
          (json['wind_speed_10m'] as num).toDouble(),
      codigo:
          (json['weather_code'] as num).toInt(),
    );
  }

  // DESCRIPCION DEL CLIMA
  String get descripcion {
    if (codigo == 0) return 'Despejado';
    if (codigo == 1) return 'Mayormente despejado';
    if (codigo == 2) return 'Parcialmente nublado';
    if (codigo == 3) return 'Nublado';

    if (codigo == 45 || codigo == 48) {
      return 'Niebla';
    }

    if (codigo >= 51 && codigo <= 57) {
      return 'Llovizna';
    }

    if (codigo >= 61 && codigo <= 67) {
      return 'Lluvia';
    }

    if (codigo >= 71 && codigo <= 77) {
      return 'Nieve';
    }

    if (codigo >= 80 && codigo <= 82) {
      return 'Chubascos';
    }

    if (codigo == 85 || codigo == 86) {
      return 'Chubascos de nieve';
    }

    if (codigo >= 95) {
      return 'Tormenta eléctrica';
    }

    return 'Condición variable';
  }

  // ICONO SEGUN EL CLIMA
  IconData get icono {
    if (codigo == 0 || codigo == 1) {
      return Icons.wb_sunny;
    }

    if (codigo == 2 || codigo == 3) {
      return Icons.cloud;
    }

    if (codigo == 45 || codigo == 48) {
      return Icons.foggy;
    }

    if (codigo >= 51 && codigo <= 67) {
      return Icons.grain;
    }

    if (codigo >= 71 && codigo <= 86) {
      return Icons.ac_unit;
    }

    if (codigo >= 95) {
      return Icons.thunderstorm;
    }

    return Icons.cloud_queue;
  }
}
