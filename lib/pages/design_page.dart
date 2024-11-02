import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noi_design/services/design_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String? selectedUnity;
  String? planoFilePath;
  String? imageFilePath;

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  _buildTitle(),
                  const SizedBox(height: 10),
                  _buildSubtitle(),
                  const SizedBox(height: 30),
                  _buildForm(),
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

  Widget _buildForm() {
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
              _buildSubmitButton(),
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
          onPressed: () {
            // Lógica de carga de archivos para plano
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
          onPressed: () {
            // Lógica de carga de imágenes
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
          selectedUnity = value; // Actualizar la variable seleccionada
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
      'Asegúrate de llenar todos los campos correctamente.',
      style: TextStyle(color: Colors.red),
      textAlign: TextAlign.center,
    );
  }

  // Método para el botón de envío
  Widget _buildSubmitButton() {
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
                selectedUnity: selectedUnity,
                planoFilePath: planoFilePath,
                imageFilePath: imageFilePath,
              );

              try {
                final userService =
                    Provider.of<DesignService>(context, listen: false);
                await userService.addDesign(newDesignRequest);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Solicitud enviada correctamente"),
                      content: Text("Tu solicitud ha sido enviada con éxito."),
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
                // Limpiar el formulario
                setState(() {
                  selectedContact = '';
                  description = '';
                  selectedUnity = null;
                  planoFilePath = null;
                  imageFilePath = null;
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
