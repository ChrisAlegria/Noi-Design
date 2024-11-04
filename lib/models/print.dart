import 'dart:convert';

class Print {
  String selectedContact; // Medio de contacto (antes "medioContacto")
  String description; // Descripción de la impresión
  String escala; // Escala de impresión
  String material; // Material de impresión
  String? modelo; // Modelo de impresión
  String? id; // ID del objeto Print (opcional)
  String userEmail; // Email del usuario que inició sesión

  Print({
    required this.selectedContact,
    required this.description,
    required this.userEmail,
    required this.material,
    required this.escala,
    this.modelo,
    this.id,
  });

  // Convertir a JSON
  String toJson() => json.encode(toMap());

  // Crear desde JSON
  factory Print.fromJson(String str) => Print.fromMap(json.decode(str));

  // Crear desde un mapa de datos
  factory Print.fromMap(Map<String, dynamic> json) => Print(
        selectedContact: json["selectedContact"],
        description: json["description"],
        modelo: json["selectedModel"],
        material: json["selectedMaterial"],
        escala: json["selectedScale"],
        id: json["id"], // Asignamos el id (si existe)
        userEmail: json["userEmail"], // Asegúrate de incluir el userEmail aquí
      );

  // Convertir a un mapa de datos
  Map<String, dynamic> toMap() => {
        "selectedContact": selectedContact,
        "description": description,
        "selectedModel": modelo,
        "selectedMaterial": material,
        "selectedScale": escala,
        "id": id, // Agrega el id al mapa (si existe)
        "userEmail": userEmail, // Agrega el userEmail al mapa
      };
}
