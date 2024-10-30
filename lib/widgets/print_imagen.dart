import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 41, 123, 1),
                  Color.fromRGBO(99, 152, 254, 1),
                ],
              ),
            ),
          ),
          // Contenido principal
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  Text(
                    'Solicitud de Impresión 3D',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Completa el siguiente formulario para solicitar tu impresión 3D.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Formulario
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Carga de archivos
                          Text(
                            'Sube tu archivo (.stl, .sldprt)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 56, 165, 1),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Lógica de carga de archivos
                            },
                            child: Text('Seleccionar archivo'),
                          ),
                          SizedBox(height: 20),

                          // Selección de material
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Material de impresión',
                              border: OutlineInputBorder(),
                            ),
                            items: ['Filamento', 'Resina']
                                .map((material) => DropdownMenuItem(
                                      value: material,
                                      child: Row(
                                        children: [
                                          Icon(
                                            material == 'Filamento'
                                                ? FontAwesomeIcons.cube
                                                : FontAwesomeIcons.water,
                                            color: Colors.grey,
                                            size:
                                                18, // Tamaño reducido del ícono
                                          ),
                                          SizedBox(width: 10),
                                          Text(material),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              // Lógica de selección de material
                            },
                          ),
                          SizedBox(height: 20),

                          // Selección de escala
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Escala de impresión',
                              border: OutlineInputBorder(),
                            ),
                            items: ['100%', '75%', '50%', '25%'].map((scale) {
                              double iconSize;
                              switch (scale) {
                                case '100%':
                                  iconSize = 18.0; // Reducido solo en 100%
                                  break;
                                case '75%':
                                  iconSize = 16.0; // Reducido
                                  break;
                                case '50%':
                                  iconSize = 14.0; // Reducido
                                  break;
                                case '25%':
                                  iconSize = 12.0; // Reducido
                                  break;
                                default:
                                  iconSize = 18.0;
                              }
                              return DropdownMenuItem(
                                value: scale,
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.expand,
                                      color: Colors.grey,
                                      size: iconSize,
                                    ),
                                    SizedBox(width: 10),
                                    Text(scale),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // Lógica de selección de escala
                            },
                          ),
                          SizedBox(height: 20),

                          // Descripción de la impresión
                          TextFormField(
                            decoration: InputDecoration(
                              labelText:
                                  'Descripción detallada de la impresión',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                          SizedBox(height: 20),

                          // Selección de contacto
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Medio de contacto preferido',
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'Correo electrónico',
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.envelope,
                                      color: Colors.grey,
                                      size: 18, // Tamaño reducido del ícono
                                    ),
                                    SizedBox(width: 10),
                                    Text('Correo electrónico'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'WhatsApp',
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                      size: 18, // Tamaño reducido del ícono
                                    ),
                                    SizedBox(width: 10),
                                    Text('WhatsApp'),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              // Lógica de selección de contacto
                            },
                          ),
                          SizedBox(height: 20),

                          // Mensaje informativo
                          Text(
                            'Una vez enviada la solicitud, será revisada por un asesor experto de Noi Design. '
                            'Dentro de 1 a 2 días hábiles nos pondremos en contacto con usted por medio de su preferencia '
                            'para confirmar la solicitud y resolver cualquier duda.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Botón de envío
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(0, 56, 165, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Lógica de envío de formulario
                                _showConfirmationDialog(context);
                              },
                              child: Text(
                                'Enviar solicitud',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Diseño enviado!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Se ha enviado tu diseño.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Ahora tu idea está esperando ser revisada por nuestro equipo. '
                'Pronto nos pondremos en contacto contigo.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Aquí puedes agregar la lógica para regresar al menú
              },
              child: Text('Regresar al menú'),
            ),
          ],
        );
      },
    );
  }
}
