import 'dart:convert';

class Design {
  String selectedContact;
  String description;
  String? unidad;
  String? plano;
  String? imagenes;
  String? id;

  Design({
    required this.selectedContact,
    required this.description,
    this.unidad,
    this.plano,
    this.imagenes,
    this.id,
  });

  // Convertir a JSON
  String toJson() => json.encode(toMap());

  // Crear desde JSON
  factory Design.fromJson(String str) => Design.fromMap(json.decode(str));

  // Crear desde un mapa de datos
  factory Design.fromMap(Map<String, dynamic> json) => Design(
        selectedContact: json["selectedContact"],
        description: json["description"],
        unidad: json["selectedUnity"],
        plano: json["planoFilePath"],
        imagenes: json["imageFilePath"],
        id: json["id"], // Directamente asignamos el id sin comprobar si existe
      );

  // Convertir a un mapa de datos
  Map<String, dynamic> toMap() => {
        "selectedContact": selectedContact,
        "description": description,
        "selectedUnity": unidad,
        "planoFilePath": plano,
        "imageFilePath": imagenes,
        "id": id, // Agregamos el id al mapa
      };
}
