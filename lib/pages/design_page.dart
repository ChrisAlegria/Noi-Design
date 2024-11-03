import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noi_design/services/design_service.dart';
import 'package:noi_design/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noi_design/widgets/global_user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:noi_design/models/design.dart';

class DesignPage extends StatefulWidget {
  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<DesignPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? selectedContact = '';
  String? description = '';
  String? unidad;
  String? plano;
  String? imagenes;
  String? userEmail;

  @override
  Widget build(BuildContext context) {
    final globalUser = Provider.of<GlobalUser>(context);

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  _buildTitle(),
                  const SizedBox(height: 10),
                  _buildSubtitle(),
                  const SizedBox(height: 30),
                  _buildForm(globalUser.email),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Solicitud de diseño',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Completa el siguiente formulario para solicitar tu diseño.',
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: Colors.white70),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildForm(String userEmail) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPlanoUploadField(),
              const SizedBox(height: 20),
              _buildImageUploadField(),
              const SizedBox(height: 20),
              _buildUnityDropdown(),
              const SizedBox(height: 20),
              _buildDescriptionField(),
              const SizedBox(height: 20),
              _buildContactDropdown(),
              const SizedBox(height: 20),
              _buildInfoMessage(),
              const SizedBox(height: 20),
              _buildSubmitButton(userEmail),
            ],
          ),
        ),
      ),
    );
  }

  // Método para el campo de carga de archivos de plano
  Widget _buildPlanoUploadField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sube tu plano (.rar, .zip)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 56, 165, 1),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () async {
            // Lógica de carga de archivos para plano
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['zip', 'rar'],
            );

            if (result != null) {
              plano = result.files.single.path;
              // Aquí puedes agregar lógica para subir el archivo a la base de datos
              print('Archivo de plano seleccionado: $plano');
            } else {
              // El usuario canceló la selección
              print('Selección de archivo cancelada');
            }
          },
          icon: const Icon(Icons.upload_file), // Ícono de carga
          label: const Text('Seleccionar archivo'),
        ),
      ],
    );
  }

  // Método para el campo de carga de imágenes de referencia
  Widget _buildImageUploadField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sube imágenes de referencia',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 56, 165, 1),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () async {
            // Lógica de carga de imágenes
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.image,
              allowMultiple: true, // Permite seleccionar múltiples imágenes
            );

            if (result != null) {
              imagenes =
                  result.files.map((file) => file.path).toList().toString();
              // Aquí puedes agregar lógica para subir las imágenes a la base de datos
              print('Imágenes seleccionadas: $imagenes');
            } else {
              // El usuario canceló la selección
              print('Selección de imagen cancelada');
            }
          },
          icon: const Icon(Icons.image), // Ícono de imagen
          label: const Text('Seleccionar imágenes'),
        ),
      ],
    );
  }

// Método para el Dropdown de unidad de medida
  Widget _buildUnityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Unidad de medida',
        border: OutlineInputBorder(),
      ),
      items: [
        DropdownMenuItem(
          value: 'Centimetros',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.ruler, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('Centímetros'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'Pulgadas',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.rulerCombined,
                  color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('Pulgadas'),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          unidad = value; // Actualizar la variable seleccionada
        });
      },
      validator: (value) =>
          value == null ? 'Por favor, selecciona una unidad de medida' : null,
    );
  }

  // Método para el campo de descripción
  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Descripción',
        labelStyle: TextStyle(color: Color.fromRGBO(0, 56, 165, 1)),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => description = value,
      validator: (value) => value!.isEmpty ? 'Ingresa una descripción' : null,
    );
  }

  // Método para el Dropdown de contacto
  Widget _buildContactDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Medio de contacto preferido',
        border: OutlineInputBorder(),
      ),
      items: [
        DropdownMenuItem(
          value: 'Correo electrónico',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.envelope, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('Correo electrónico'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'WhatsApp',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 18),
              const SizedBox(width: 10),
              Text('WhatsApp'),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          selectedContact = value!; // Asegúrate de que el valor no sea nulo
        });
      },
      validator: (value) =>
          value == null ? 'Por favor, selecciona un medio de contacto' : null,
    );
  }

  // Método para el mensaje de información
  Widget _buildInfoMessage() {
    return Text(
      'Asegúrate de llenar y seleccionar todos los campos.',
      style: TextStyle(color: Colors.red),
      textAlign: TextAlign.center,
    );
  }

  // Método para el botón de envío
  Widget _buildSubmitButton(String userEmail) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(0, 41, 123, 1),
      disabledColor: Colors.grey,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          _isLoading ? 'Cargando...' : 'Enviar Solicitud',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: _isLoading
          ? null
          : () async {
              FocusScope.of(context).unfocus();
              if (!_formKey.currentState!.validate()) {
                return; // Mostrar errores de validación
              }
              setState(() {
                _isLoading = true;
              });

              final newDesignRequest = Design(
                selectedContact: selectedContact ?? '',
                description: description ?? '',
                unidad: unidad,
                plano: plano,
                imagenes: imagenes,
                userEmail: userEmail, // Agrega el correo aquí
              );

              try {
                final userService =
                    Provider.of<DesignService>(context, listen: false);
                await userService.addDesign(newDesignRequest);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("!Diseño Enviado¡"),
                      content: Text(
                          "Ahora tu idea está esperando ser revisada por nuestro equipo. Nos pondremos en contacto contigo pronto."),
                      actions: [
                        TextButton(
                          child: Text("Aceptar"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Cerrar diálogo
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
                // Limpiar el formulario
                setState(() {
                  selectedContact = '';
                  description = '';
                  unidad = null;
                  plano = null;
                  imagenes = null;
                  _isLoading = false;
                });
              } catch (error) {
                print('Error al enviar la solicitud: $error');
                setState(() {
                  _isLoading = false;
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("Hubo un error al enviar la solicitud."),
                      actions: [
                        TextButton(
                          child: Text("Aceptar"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Cerrar diálogo
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
    );
  }
}
