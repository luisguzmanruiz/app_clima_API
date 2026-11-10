
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/clima.dart';

class ClimaService {

  // BUSCAR CIUDAD
  Future<Map<String, dynamic>> buscarCiudad(
    String nombreCiudad,
  ) async {

    final url = Uri.https(
      'geocoding-api.open-meteo.com',
      '/v1/search',
      {
        'name': nombreCiudad,
        'count': '1',
        'language': 'es',
        'format': 'json',
      },
    );

    // PETICION GET
    final respuesta = await http.get(url);

    if (respuesta.statusCode != 200) {
      throw Exception('Error al buscar la ciudad');
    }

    final datos = jsonDecode(respuesta.body);

    if (datos['results'] == null ||
        (datos['results'] as List).isEmpty) {
      throw Exception('No se encontró la ciudad');
    }

    return datos['results'][0];
  }

  // OBTENER CLIMA
  Future<Clima> obtenerClima(
    String nombreCiudad,
    double latitud,
    double longitud,
  ) async {

    final url = Uri.https(
      'api.open-meteo.com',
      '/v1/forecast',
      {
        'latitude': latitud.toString(),
        'longitude': longitud.toString(),
        'current':
            'temperature_2m,relative_humidity_2m,'
            'apparent_temperature,weather_code,wind_speed_10m',
        'timezone': 'auto',
      },
    );

    // PETICION GET
    final respuesta = await http.get(url);

    if (respuesta.statusCode != 200) {
      throw Exception('Error al obtener el clima');
    }

    final datos = jsonDecode(respuesta.body);

    // CONVERTIR RESPUESTA A OBJETO CLIMA
    return Clima.fromJson(
      datos['current'],
      nombreCiudad,
    );
  }

  // METODO PRINCIPAL PARA CONSULTAR EL CLIMA
  Future<Clima> consultarClima(
    String nombreCiudad,
  ) async {

    // PRIMERO BUSCAMOS LA CIUDAD
    final datosCiudad = await buscarCiudad(nombreCiudad);

    final double latitud =
        (datosCiudad['latitude'] as num).toDouble();

    final double longitud =
        (datosCiudad['longitude'] as num).toDouble();

    final String nombreEncontrado =
        datosCiudad['name'];

    // DESPUES CONSULTAMOS EL CLIMA
    return obtenerClima(
      nombreEncontrado,
      latitud,
      longitud,
    );
  }
}
