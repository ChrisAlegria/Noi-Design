import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noi_design/pages/home_page.dart';

class PrintPage extends StatefulWidget {
  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedMaterial;
  String? selectedScale;
  String? selectedContact;
  String description = '';

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

  // Método para construir el título
  Widget _buildTitle() {
    return Text(
      'Solicitud de Impresión 3D',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
    );
  }

  // Método para construir el subtítulo
  Widget _buildSubtitle() {
    return Text(
      'Completa el siguiente formulario para solicitar tu impresión 3D.',
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: Colors.white70),
      textAlign: TextAlign.center,
    );
  }

  // Método para construir el formulario
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
              _buildFileUploadField(),
              const SizedBox(height: 20),
              _buildMaterialDropdown(),
              const SizedBox(height: 20),
              _buildScaleDropdown(),
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

  // Método para el campo de carga de archivos
  Widget _buildFileUploadField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sube tu archivo (.stl, .sldprt)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 56, 165, 1),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Lógica de carga de archivos
          },
          child: const Text('Seleccionar archivo'),
        ),
      ],
    );
  }

  // Método para el Dropdown de material
  Widget _buildMaterialDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Material de impresión',
        border: OutlineInputBorder(),
      ),
      items: ['Filamento', 'Resina'].map((material) {
        return DropdownMenuItem(
          value: material,
          child: Row(
            children: [
              Icon(
                material == 'Filamento'
                    ? FontAwesomeIcons.cube
                    : FontAwesomeIcons.water,
                color: Colors.grey,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(material),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedMaterial = value;
        });
      },
      validator: (value) =>
          value == null ? 'Por favor, selecciona un material' : null,
    );
  }

  // Método para el Dropdown de escala
  Widget _buildScaleDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Escala de impresión',
        border: OutlineInputBorder(),
      ),
      items: ['100%', '75%', '50%', '25%'].map((scale) {
        double iconSize;
        switch (scale) {
          case '100%':
            iconSize = 18.0;
            break;
          case '75%':
            iconSize = 16.0;
            break;
          case '50%':
            iconSize = 14.0;
            break;
          case '25%':
            iconSize = 12.0;
            break;
          default:
            iconSize = 18.0;
        }
        return DropdownMenuItem(
          value: scale,
          child: Row(
            children: [
              Icon(FontAwesomeIcons.expand, color: Colors.grey, size: iconSize),
              const SizedBox(width: 10),
              Text(scale),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedScale = value;
        });
      },
      validator: (value) =>
          value == null ? 'Por favor, selecciona una escala' : null,
    );
  }

  // Método para el campo de descripción
  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Descripción detallada de la impresión',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      onChanged: (value) {
        description = value;
      },
      validator: (value) => (value == null || value.isEmpty)
          ? 'Por favor, ingresa una descripción'
          : null,
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
          selectedContact = value;
        });
      },
      validator: (value) =>
          value == null ? 'Por favor, selecciona un medio de contacto' : null,
    );
  }

  // Método para el mensaje informativo
  Widget _buildInfoMessage() {
    return Text(
      'Una vez enviada la solicitud, será revisada por un asesor experto de Noi Design. '
      'Dentro de 1 a 2 días hábiles nos pondremos en contacto con usted por medio de su preferencia '
      'para confirmar la solicitud y resolver cualquier duda.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54,
        fontStyle: FontStyle.italic,
        fontSize: 10,
      ),
    );
  }

  // Método para el botón de envío
  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(0, 56, 165, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Validar el formulario
          if (_formKey.currentState!.validate()) {
            // Lógica de envío de formulario
            _showConfirmationDialog(context);
          }
        },
        child: const Text(
          'Enviar solicitud',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Método para mostrar el diálogo de confirmación
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Diseño enviado!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Ahora tu idea está esperando ser revisada por nuestro equipo. Nos pondremos en contacto contigo pronto.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
