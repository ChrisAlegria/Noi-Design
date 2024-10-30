import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noi_design/models/users.dart';

class UserService extends ChangeNotifier {
  final String _baseURL = "prints-4a69e-default-rtdb.firebaseio.com";

  final List<Users> users = []; // Lista para almacenar los usuarios
  bool isLoading = true;
  Users? selectedUser;

  UserService() {
    getUsers(); // Llama al método para obtener usuarios al inicializar
  }

  // Función para obtener los usuarios
  Future<void> getUsers() async {
    isLoading = true;
    notifyListeners(); // Notifica a los oyentes que está cargando

    final url =
        Uri.https(_baseURL, 'users.json'); // Endpoint para obtener los usuarios
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(resp.body) ?? {};

      // Limpiamos la lista para evitar duplicados al refrescar
      users.clear();

      // Recorremos el mapa de la respuesta y agregamos usuarios a la lista
      userData.forEach((key, value) {
        final tempUser = Users.fromMap(value);
        tempUser.id = key; // Asigna el ID proporcionado por Firebase
        users.add(tempUser);
      });
    } else {
      throw Exception('Error al cargar usuarios'); // Maneja errores de red
    }

    isLoading = false;
    notifyListeners(); // Notifica a los oyentes de los cambios
  }

  // Función para agregar un nuevo usuario
  Future<void> addUser(Users user) async {
    final url = Uri.https(_baseURL, 'users.json');
    final response = await http.post(url, body: user.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      user.id = responseData[
          'name']; // Asigna el ID del nuevo usuario generado por Firebase
      users.add(user);
      notifyListeners(); // Notifica a los oyentes que se ha agregado un nuevo usuario
    } else {
      throw Exception('Error al agregar usuario');
    }
  }

  // Función para actualizar un usuario existente
  Future<void> updateUser(Users user) async {
    if (user.id == null) return; // Evita actualizar usuarios sin ID

    final url = Uri.https(_baseURL, 'users/${user.id}.json');
    final response = await http.put(url, body: user.toJson());

    if (response.statusCode == 200) {
      final int index = users.indexWhere((u) => u.id == user.id);
      if (index >= 0) {
        users[index] = user;
        notifyListeners(); // Notifica a los oyentes que se ha actualizado un usuario
      }
    } else {
      throw Exception('Error al actualizar usuario');
    }
  }

  // Función para eliminar un usuario existente
  Future<void> deleteUser(String userId) async {
    final url = Uri.https(_baseURL, 'users/$userId.json');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      users.removeWhere((user) => user.id == userId);
      notifyListeners(); // Notifica a los oyentes que se ha eliminado un usuario
    } else {
      throw Exception('Error al eliminar usuario');
    }
  }
}
