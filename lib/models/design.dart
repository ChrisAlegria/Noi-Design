import 'dart:convert';

class Design {
  String selectedContact;
  String description;
  String? selectedUnity;
  String? planoFilePath;
  String? imageFilePath;
  String? id;

  Design({
    required this.selectedContact,
    required this.description,
    this.selectedUnity,
    this.planoFilePath,
    this.imageFilePath,
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
        selectedUnity: json["selectedUnity"],
        planoFilePath: json["planoFilePath"],
        imageFilePath: json["imageFilePath"],
        id: json["id"], // Directamente asignamos el id sin comprobar si existe
      );

  // Convertir a un mapa de datos
  Map<String, dynamic> toMap() => {
        "selectedContact": selectedContact,
        "description": description,
        "selectedUnity": selectedUnity,
        "planoFilePath": planoFilePath,
        "imageFilePath": imageFilePath,
        "id": id, // Agregamos el id al mapa
      };
}
