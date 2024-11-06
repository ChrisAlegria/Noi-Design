// auth_service.dart
import 'package:flutter/material.dart';
import 'package:noi_design/pages/login_page.dart';
import 'package:provider/provider.dart'; // Importa Provider si no lo tienes
import 'package:noi_design/widgets/global_user.dart'; // Asegúrate de importar tu GlobalUser

// Función global de Logout
void logout(BuildContext context) {
  // Accede a GlobalUser y limpia el email
  final globalUser = Provider.of<GlobalUser>(context, listen: false);
  globalUser.clearUser(); // Limpia los datos del usuario

  // Redirige al usuario a la pantalla de Home
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>
          LoginPage(), // Asegúrate de tener HomePage implementada
    ),
  );
}
