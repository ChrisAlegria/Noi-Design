import 'dart:convert';

class DesignRequest {
  String selectedContact;
  String description;
  String? selectedUnity;
  String? planoFilePath;
  String? imageFilePath;
  String? id;

  DesignRequest({
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
  factory DesignRequest.fromJson(String str) =>
      DesignRequest.fromMap(json.decode(str));

  // Crear desde un mapa de datos
  factory DesignRequest.fromMap(Map<String, dynamic> json) => DesignRequest(
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

  // Método para crear una copia de `DesignRequest`
  DesignRequest copy() => DesignRequest(
        selectedContact: selectedContact,
        description: description,
        selectedUnity: selectedUnity,
        planoFilePath: planoFilePath,
        imageFilePath: imageFilePath,
        id: id,
      );
}
