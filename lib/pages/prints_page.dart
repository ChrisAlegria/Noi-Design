import 'package:flutter/material.dart';
import 'package:noi_design/pages/orders_page.dart';
import 'package:provider/provider.dart';
import 'package:noi_design/services/print_service.dart';
import 'package:noi_design/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noi_design/widgets/global_user.dart';
import 'package:noi_design/models/print.dart';
import 'package:noi_design/widgets/auth_service.dart';

class PrintPage extends StatefulWidget {
  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? titulo = '';
  String? selectedContact = '';
  String? description = '';
  String? escala = '';
  String? material = '';
  String? id;
  String? userEmail;

  @override
  Widget build(BuildContext context) {
    final globalUser = Provider.of<GlobalUser>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: Center(
          child: Text(
            "Realizar Pedido De Impresión",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(0, 41, 123, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Logo.jpg'),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.person,
              color: Color.fromRGBO(0, 41, 123, 1),
            ),
            onSelected: (String value) {
              if (value == 'Mis pedidos') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdersPage(),
                  ),
                );
              } else if (value == 'Historial de pedidos') {
                // Navegar a la pantalla de historial de pedidos
                Navigator.pushNamed(context, 'historial_pedidos');
              } else if (value == 'Logout') {
                logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return const {'Mis pedidos', 'Historial de pedidos', 'Logout'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
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
              _buildReference(),
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
              _buildSubmitButton(userEmail),
            ],
          ),
        ),
      ),
    );
  }

  // Método para el campo de titulo
  Widget _buildReference() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombre del proyecto',
        labelStyle: TextStyle(color: Color.fromRGBO(0, 56, 165, 1)),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => titulo = value,
      validator: (value) =>
          value!.isEmpty ? 'Por favor, ingresa un nombre de proyecto' : null,
    );
  }

  // Método para el Dropdown de material
  Widget _buildMaterialDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Material de impresión',
        border: OutlineInputBorder(),
      ),
      items: [
        DropdownMenuItem(
          value: 'Filamento',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.cube, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('Filamento'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'Resina',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.water, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('Resina'),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          material = value; // Actualizar la variable seleccionada
        });
      },
      validator: (value) => value == null
          ? 'Por favor, selecciona un material de impresion'
          : null,
    );
  }

  // Método para el Dropdown de escala
  Widget _buildScaleDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Escala de impresión',
        border: OutlineInputBorder(),
      ),
      items: [
        DropdownMenuItem(
          value: '100%',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.expand, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('100%'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: '75%',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.expand, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('75%'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: '50%',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.expand, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('50%'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: '25%',
          child: Row(
            children: [
              Icon(FontAwesomeIcons.expand, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Text('25%'),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          escala = value;
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
          selectedContact = value!;
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

              final newPrintRequest = Print(
                titulo: titulo ?? '',
                selectedContact: selectedContact ?? '',
                description: description ?? '',
                escala: escala ?? '',
                material: material ?? '',
                userEmail: userEmail,
              );

              try {
                final userService =
                    Provider.of<PrintService>(context, listen: false);
                await userService.addPrint(newPrintRequest);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Impresión Enviada"),
                      content: Text(
                          "Ahora tu modelo está esperando ser revisada por nuestro equipo. Nos pondremos en contacto contigo pronto."),
                      actions: [
                        TextButton(
                          child: Text("Aceptar"),
                          onPressed: () {
                            Navigator.of(context).pop();
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
                  titulo = '';
                  selectedContact = '';
                  description = '';
                  escala = null;
                  material = null;
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
                            Navigator.of(context).pop();
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
