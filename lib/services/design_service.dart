import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noi_design/models/design.dart';

class DesignService extends ChangeNotifier {
  final String _baseURL = "prints-4a69e-default-rtdb.firebaseio.com";

  final List<Design> design =
      []; // Lista para almacenar las solicitudes de diseño
  bool isLoading = true;
  Design? selectedDesignRequest;

  DesignService() {
    getDesignRequests(); // Llama al método para obtener solicitudes de diseño al inicializar
  }

  // Función para obtener las solicitudes de diseño
  Future<void> getDesignRequests() async {
    isLoading = true;
    notifyListeners(); // Notifica a los oyentes que está cargando

    final url = Uri.https(_baseURL,
        'design.json'); // Endpoint para obtener las solicitudes de diseño
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> designData = jsonDecode(resp.body) ?? {};

      // Limpiamos la lista para evitar duplicados al refrescar
      design.clear();

      // Recorremos el mapa de la respuesta y agregamos solicitudes a la lista
      designData.forEach((key, value) {
        final tempDesignRequest = Design.fromMap(value);
        tempDesignRequest.id = key; // Asigna el ID proporcionado por Firebase
        design.add(tempDesignRequest);
      });
    } else {
      throw Exception(
          'Error al cargar solicitudes de diseño'); // Maneja errores de red
    }

    isLoading = false;
    notifyListeners(); // Notifica a los oyentes de los cambios
  }

  // Función para agregar una nueva solicitud de diseño
  Future<void> addDesign(Design designRequest) async {
    final url = Uri.https(_baseURL, 'design.json');
    final response = await http.post(url, body: designRequest.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      designRequest.id = responseData[
          'name']; // Asigna el ID del nuevo diseño generado por Firebase
      design.add(designRequest);
      notifyListeners(); // Notifica a los oyentes que se ha agregado una nueva solicitud de diseño
    } else {
      throw Exception('Error al agregar solicitud de diseño');
    }
  }
}
