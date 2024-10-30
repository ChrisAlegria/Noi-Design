import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noi_design/widgets/card_container.dart';
import 'package:noi_design/widgets/fondo_login.dart';
import 'package:noi_design/services/user_service.dart';
import 'package:noi_design/models/users.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FondoLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Crear Cuenta',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 30),
                    _RegisterForm(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  __RegisterFormState createState() => __RegisterFormState();
}

class __RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? _name;
  String? _email;
  String? _phone;
  String? _password;

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // Campo de Nombre
          TextFormField(
            autocorrect: false,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(0, 41, 123, 1), width: 2),
              ),
              labelText: 'Nombre',
              labelStyle: TextStyle(
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
            ),
            onChanged: (value) => _name = value,
            validator: (value) {
              return value != null && value.trim().isNotEmpty
                  ? null
                  : 'El nombre no puede estar vacío';
            },
          ),
          SizedBox(height: 30),

          // Campo de Contraseña
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(0, 41, 123, 1), width: 2),
              ),
              labelText: 'Contraseña',
              labelStyle: TextStyle(
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
            ),
            onChanged: (value) => _password = value,
            validator: (value) {
              return value != null && value.length >= 6
                  ? null
                  : 'La contraseña debe tener al menos 6 caracteres';
            },
          ),
          SizedBox(height: 30),

          // Campo de Correo Electrónico
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(0, 41, 123, 1), width: 2),
              ),
              labelText: 'Correo Electrónico',
              hintText: 'ejemplo: juan@gmail.com',
              labelStyle: TextStyle(
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
              prefixIcon: Icon(
                Icons.alternate_email_sharp,
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
            ),
            onChanged: (value) => _email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El correo no es válido';
            },
          ),
          SizedBox(height: 30),

          // Campo de Teléfono
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(0, 41, 123, 1), width: 2),
              ),
              labelText: 'Número Telefónico',
              labelStyle: TextStyle(
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
              prefixIcon: Icon(
                Icons.phone,
                color: Color.fromRGBO(0, 41, 123, 1),
              ),
            ),
            onChanged: (value) => _phone = value,
            validator: (value) {
              return value != null && value.length >= 10
                  ? null
                  : 'El número telefónico debe tener al menos 10 dígitos';
            },
          ),

          SizedBox(height: 30),

          // Botón de Crear Cuenta
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromRGBO(0, 41, 123, 1),
            disabledColor: Colors.grey,
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                _isLoading ? 'Cargando...' : 'Crear Cuenta',
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

                    final newUser = Users(
                      nombre: _name ?? '',
                      email: _email ?? '',
                      phone: _phone ?? '',
                      password: _password ?? '',
                    );

                    try {
                      await userService.addUser(newUser);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Usuario creado correctamente"),
                            content: Text(
                                "Ya podrás acceder usando los datos de tu cuenta."),
                            actions: [
                              TextButton(
                                child: Text("Regresar a Inicio de Sesión"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Cerrar diálogo
                                  Navigator.of(context)
                                      .pop(); // Regresar a la pantalla anterior
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error al registrar usuario: $e'),
                        ),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
          ),
        ],
      ),
    );
  }
}
