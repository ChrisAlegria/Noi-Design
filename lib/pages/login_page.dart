import 'package:flutter/material.dart';
import 'package:noi_design/providers/login_form_provider.dart';
import 'package:noi_design/widgets/card_container.dart';
import 'package:noi_design/widgets/fondo_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
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
                      'Iniciar Sesion',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context,
                      'register'); // Navega a la página de inicio de sesión
                },
                child: Text(
                  '¿Aun no tienes una cuenta? Crea una',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
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
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 41, 123, 1),
                    width: 2,
                  ),
                ),
                labelText: 'Correo Electronico',
                hintText: 'ejemplo: juan@gmail.com',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
                prefixIcon: Icon(
                  Icons.alternate_email_sharp,
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es valido';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 41, 123, 1),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 41, 123, 1),
                    width: 2,
                  ),
                ),
                labelText: 'Contraseña',
                hintText: '*****',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Color.fromRGBO(0, 41, 123, 1),
                ),
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return 'La contraseña debe tener al menos 6 caracteres';
                }
              },
            ),
            SizedBox(height: 30),
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
                  loginForm.isLoading ? 'Cargando...' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!loginForm.isValidForm()) return;

                      // Llama a loginUser para verificar las credenciales
                      final errorMessage = await loginForm.loginUser(context);

                      // Si hay un error, muestra el mensaje
                      if (errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Verificar si el correo es admin
                        if (loginForm.email == 'admin@gmail.com') {
                          // Si el correo es admin, navega a la página de administración
                          Navigator.pushReplacementNamed(context, 'adminPage');
                        } else {
                          // Si el correo es cualquier otro, navega al home
                          Navigator.pushReplacementNamed(context, 'home');
                        }
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
