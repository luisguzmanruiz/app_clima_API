
import 'package:flutter/material.dart';
import '../models/clima.dart';
import '../services/clima_service.dart';
import '../widgets/tarjeta_dato.dart';

class PantallaClima extends StatefulWidget {
  const PantallaClima({super.key});

  @override
  State<PantallaClima> createState() =>
      _PantallaClimaState();
}

class _PantallaClimaState extends State<PantallaClima> {

  final TextEditingController ciudadController =
      TextEditingController(text: 'Tijuana');

  final ClimaService climaService = ClimaService();

  Clima? clima;

  bool cargando = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    buscarClima('Tijuana');
  }

  // CONSULTAR CLIMA
  Future<void> buscarClima(String ciudad) async {

    if (ciudad.trim().isEmpty) {
      setState(() {
        error = 'Escribe el nombre de una ciudad';
      });
      return;
    }

    setState(() {
      cargando = true;
      error = '';
    });

    try {

      // LLAMAMOS AL SERVICIO DE LA API
      final resultado =
          await climaService.consultarClima(ciudad.trim());

      if (!mounted) return;

      setState(() {
        clima = resultado;
        cargando = false;
      });

    } catch (e) {

      if (!mounted) return;

      setState(() {
        error = e.toString().replaceFirst('Exception: ', '');
        cargando = false;
      });
    }
  }

  @override
  void dispose() {
    ciudadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1565C0),
              Color(0xFF42A5F5),
              Color(0xFF90CAF9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),

            child: Column(
              children: [

                const SizedBox(height: 20),

                const Text(
                  'CLIMA APP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Consulta el clima de cualquier ciudad',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // BUSCADOR
                TextField(
                  controller: ciudadController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),

                  decoration: InputDecoration(
                    hintText: 'Escribe una ciudad...',
                    prefixIcon: const Icon(Icons.location_on),
                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  onSubmitted: (valor) {
                    buscarClima(valor);
                  },
                ),

                const SizedBox(height: 12),

                // BOTON CONSULTAR
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton.icon(
                    onPressed: cargando
                        ? null
                        : () {
                            buscarClima(
                              ciudadController.text,
                            );
                          },

                    icon: const Icon(Icons.search),

                    label: const Text(
                      'Consultar clima',
                      style: TextStyle(fontSize: 16),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // INDICADOR DE CARGA
                if (cargando)

                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )

                // MENSAJE DE ERROR
                else if (error.isNotEmpty)

                  Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      children: [

                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 45,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          error,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),

                        ElevatedButton(
                          onPressed: () {
                            buscarClima(
                              ciudadController.text,
                            );
                          },
                          child: const Text(
                            'Intentar nuevamente',
                          ),
                        ),
                      ],
                    ),
                  )

                // INFORMACION DEL CLIMA
                else if (clima != null) ...[

                  Text(
                    clima!.ciudad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 15),

                  Icon(
                    clima!.icono,
                    color: Colors.white,
                    size: 100,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '${clima!.temperatura.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 65,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  Text(
                    clima!.descripcion,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // SENSACION TERMICA Y HUMEDAD
                  Row(
                    children: [

                      Expanded(
                        child: TarjetaDato(
                          icono: Icons.thermostat,
                          titulo: 'Sensación térmica',
                          valor:
                              '${clima!.sensacion.toStringAsFixed(1)}°C',
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: TarjetaDato(
                          icono: Icons.water_drop,
                          titulo: 'Humedad',
                          valor: '${clima!.humedad}%',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // VIENTO
                  TarjetaDato(
                    icono: Icons.air,
                    titulo: 'Velocidad del viento',
                    valor:
                        '${clima!.viento.toStringAsFixed(1)} km/h',
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Datos obtenidos desde Open-Meteo API',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
