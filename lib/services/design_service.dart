import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noi_design/models/design.dart';

class DesignService extends ChangeNotifier {
  final String _baseURL = "prints-4a69e-default-rtdb.firebaseio.com";

  final List<DesignRequest> designRequests =
      []; // Lista para almacenar las solicitudes de diseño
  bool isLoading = true;
  DesignRequest? selectedDesignRequest;

  DesignService() {
    getDesignRequests(); // Llama al método para obtener solicitudes de diseño al inicializar
  }

  // Función para obtener las solicitudes de diseño
  Future<void> getDesignRequests() async {
    isLoading = true;
    notifyListeners(); // Notifica a los oyentes que está cargando

    final url = Uri.https(_baseURL,
        'design_requests.json'); // Endpoint para obtener las solicitudes de diseño
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> designData = jsonDecode(resp.body) ?? {};

      // Limpiamos la lista para evitar duplicados al refrescar
      designRequests.clear();

      // Recorremos el mapa de la respuesta y agregamos solicitudes a la lista
      designData.forEach((key, value) {
        final tempDesignRequest = DesignRequest.fromMap(value);
        tempDesignRequest.id = key; // Asigna el ID proporcionado por Firebase
        designRequests.add(tempDesignRequest);
      });
    } else {
      throw Exception(
          'Error al cargar solicitudes de diseño'); // Maneja errores de red
    }

    isLoading = false;
    notifyListeners(); // Notifica a los oyentes de los cambios
  }

  // Función para agregar una nueva solicitud de diseño
  Future<void> addDesign(DesignRequest designRequest) async {
    final url = Uri.https(_baseURL, 'design_requests.json');
    final response = await http.post(url, body: designRequest.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      designRequest.id = responseData[
          'name']; // Asigna el ID del nuevo diseño generado por Firebase
      designRequests.add(designRequest);
      notifyListeners(); // Notifica a los oyentes que se ha agregado una nueva solicitud de diseño
    } else {
      throw Exception('Error al agregar solicitud de diseño');
    }
  }

  // Función para actualizar una solicitud de diseño existente
  Future<void> updateDesignRequest(DesignRequest designRequest) async {
    if (designRequest.id == null) return; // Evita actualizar solicitudes sin ID

    final url = Uri.https(_baseURL, 'design_requests/${designRequest.id}.json');
    final response = await http.put(url, body: designRequest.toJson());

    if (response.statusCode == 200) {
      final int index =
          designRequests.indexWhere((d) => d.id == designRequest.id);
      if (index >= 0) {
        designRequests[index] = designRequest;
        notifyListeners(); // Notifica a los oyentes que se ha actualizado una solicitud de diseño
      }
    } else {
      throw Exception('Error al actualizar solicitud de diseño');
    }
  }

  // Función para eliminar una solicitud de diseño existente
  Future<void> deleteDesignRequest(String designRequestId) async {
    final url = Uri.https(_baseURL, 'design_requests/$designRequestId.json');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      designRequests.removeWhere((request) => request.id == designRequestId);
      notifyListeners(); // Notifica a los oyentes que se ha eliminado una solicitud de diseño
    } else {
      throw Exception('Error al eliminar solicitud de diseño');
    }
  }
}
