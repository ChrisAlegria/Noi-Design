import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noi_design/models/print.dart';

class PrintService extends ChangeNotifier {
  final String _baseURL = "prints-4a69e-default-rtdb.firebaseio.com";

  final List<Print> prints =
      []; // Lista para almacenar las solicitudes de impresión
  bool isLoading = true;
  Print? selectedPrintRequest;

  PrintService() {
    getPrintRequests(); // Llama al método para obtener solicitudes de impresión al inicializar
  }

  // Función para obtener las solicitudes de impresión
  Future<void> getPrintRequests() async {
    isLoading = true;
    notifyListeners(); // Notifica a los oyentes que está cargando

    final url = Uri.https(_baseURL,
        'print.json'); // Endpoint para obtener las solicitudes de impresión
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> printData = jsonDecode(resp.body) ?? {};

      // Limpiamos la lista para evitar duplicados al refrescar
      prints.clear();

      // Recorremos el mapa de la respuesta y agregamos solicitudes a la lista
      printData.forEach((key, value) {
        final tempPrintRequest = Print.fromMap(value);
        tempPrintRequest.id = key; // Asigna el ID proporcionado por Firebase
        prints.add(tempPrintRequest);
      });
    } else {
      throw Exception(
          'Error al cargar solicitudes de impresión'); // Maneja errores de red
    }

    isLoading = false;
    notifyListeners(); // Notifica a los oyentes de los cambios
  }

  // Función para agregar una nueva solicitud de impresión
  Future<void> addPrint(Print printRequest) async {
    final url = Uri.https(_baseURL, 'print.json');
    final response = await http.post(url, body: printRequest.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      printRequest.id = responseData[
          'name']; // Asigna el ID del nuevo print generado por Firebase
      prints.add(printRequest);
      notifyListeners(); // Notifica a los oyentes que se ha agregado una nueva solicitud de impresión
    } else {
      throw Exception('Error al agregar solicitud de impresión');
    }
  }

  // Función para eliminar una solicitud de impresión
  Future<void> deletePrint(String id) async {
    final url = Uri.https(_baseURL, 'print/$id.json');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      prints.removeWhere((print) => print.id == id);
      notifyListeners(); // Notifica a los oyentes del cambio
    } else {
      throw Exception('Error al eliminar el pedido de impresión');
    }
  }

  // Función para fianlizar una solicitud de impresión
  Future<void> finalizePrint(String id) async {
    final url = Uri.https(_baseURL, 'print/$id.json');
    final response =
        await http.patch(url, body: json.encode({"isFinalized": true}));

    if (response.statusCode == 200) {
      final print = prints.firstWhere((print) => print.id == id);
      print.isFinalized = true;
      notifyListeners();
    } else {
      throw Exception('Error al finalizar solicitud de impresión');
    }
  }
}
