import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:noi_design/models/print.dart';
import 'package:noi_design/models/design.dart';
import 'package:http/http.dart' as http;

class PrintAndDesignService extends ChangeNotifier {
  final String _baseURL = "prints-4a69e-default-rtdb.firebaseio.com";

  final List<Print> prints = []; // Lista para almacenar las impresiones
  final List<Design> designs = []; // Lista para almacenar los diseños

  bool isLoading = true;
  Print? printSeleccionado;
  Design? designSeleccionado;

  PrintAndDesignService() {
    this.obtenerPrints(); // Llama al método para obtener impresiones al inicializar
    this.obtenerDesigns(); // Llama al método para obtener diseños al inicializar
  }

  // Función para obtener las impresiones
  Future<void> obtenerPrints() async {
    this.isLoading = true;
    notifyListeners(); // Notifica a los oyentes que está cargando
    final url = Uri.https(_baseURL, 'prints.json');
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      // Verifica que la respuesta sea exitosa
      final Map<String, dynamic> printsMap = json.decode(resp.body);

      // Recorremos el mapa de la respuesta y agregamos impresiones a la lista
      printsMap.forEach((key, value) {
        final tempPrint = Print.fromMap(value);
        tempPrint.id = key;
        this.prints.add(tempPrint);
      });
    } else {
      throw Exception('Error al cargar impresiones'); // Maneja errores de red
    }

    this.isLoading = false; // Actualiza el estado de carga
    notifyListeners(); // Notifica a los oyentes de los cambios
  }

  // Método para subir una nueva impresión
  Future<void> subirPrint(Print nuevaPrint) async {
    final url = Uri.https(_baseURL, 'prints.json');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: nuevaPrint.toJson(),
    );

    if (response.statusCode == 201) {
      // Verifica que la respuesta sea exitosa
      final id = json
          .decode(response.body)['name']; // Obtiene el ID de la nueva impresión
      nuevaPrint.id = id; // Asigna el ID a la nueva impresión
      prints.add(nuevaPrint); // Agrega a la lista local
      notifyListeners(); // Notifica a los oyentes de los cambios
    } else {
      throw Exception('Error al subir la impresión'); // Maneja errores de red
    }
  }

  // Método para obtener los diseños
  Future<void> obtenerDesigns() async {
    this.isLoading = true;
    notifyListeners(); // Notifica a los oyentes que está cargando
    final url = Uri.https(_baseURL, 'designs.json');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final Map<String, dynamic> designsMap = json.decode(resp.body);

      // Recorremos el mapa de la respuesta y agregamos diseños a la lista
      designsMap.forEach((key, value) {
        final tempDesign = Design.fromMap(value);
        tempDesign.id = key;
        this.designs.add(tempDesign);
      });
    } else {
      throw Exception('Error al cargar diseños');
    }

    this.isLoading = false; // Actualiza el estado de carga
    notifyListeners(); // Notifica a los oyentes de los cambios
  }

  // Método para subir un nuevo diseño
  Future<void> subirDesign(Design nuevoDesign) async {
    final url = Uri.https(_baseURL, 'designs.json');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: nuevoDesign.toJson(),
    );
    if (response.statusCode == 201) {
      final id =
          json.decode(response.body)['name']; // Obtiene el ID del nuevo diseño
      nuevoDesign.id = id; // Asigna el ID al nuevo diseño
      designs.add(nuevoDesign); // Agrega a la lista local
      notifyListeners(); // Notifica a los oyentes de los cambios
    } else {
      throw Exception('Error al subir el diseño'); // Maneja errores de red
    }
  }

  // Método para obtener un diseño específico
  Future<Design?> obtenerDesignPorId(String id) async {
    final url = Uri.https(_baseURL, 'designs/$id.json');
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final designData = Design.fromMap(json.decode(resp.body));
      return designData;
    } else {
      throw Exception('Error al cargar el diseño'); // Maneja errores de red
    }
  }
}
