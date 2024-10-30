import 'package:flutter/material.dart';
import 'package:noi_design/services/user_service.dart';
import 'package:provider/provider.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> loginUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    // Obtén el servicio de usuarios
    final userService = Provider.of<UserService>(context, listen: false);

    // Espera a que se carguen los usuarios
    await userService.getUsers();

    // Busca un usuario que coincida con el correo y la contraseña
    for (var user in userService.users) {
      if (user.email == email && user.password == password) {
        isLoading = false;
        notifyListeners();
        return null; // Login exitoso
      }
    }

    // Si no se encuentra el usuario
    isLoading = false;
    notifyListeners();
    return "El usuario no existe o la contraseña es incorrecta";
  }
}
