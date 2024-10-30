import 'dart:convert';

class Design {
  String id; // ID del objeto Design
  String plano; // Ruta del archivo de plano
  String imagenes; // Ruta de la imagen de referencia
  String unidad; // Unidad de medida seleccionada
  String description; // Descripción del proyecto
  String selectedContact; // Medio de contacto preferido

  Design({
    required this.id,
    required this.plano,
    required this.imagenes,
    required this.unidad,
    required this.description,
    required this.selectedContact,
  });

  // Convertir desde JSON
  factory Design.fromJson(String str) => Design.fromMap(json.decode(str));

  // Convertir a JSON
  String toJson() => json.encode(toMap());

  // Convertir desde Map
  factory Design.fromMap(Map<String, dynamic> json) => Design(
        id: json["id"], // Cargar el ID
        plano: json["plano"], // Cargar la ruta del plano
        imagenes: json["imagenes"], // Cargar la ruta de la imagen de referencia
        unidad: json["unidad"], // Cargar la unidad de medida
        description: json["description"], // Cargar la descripción
        selectedContact: json["selectedContact"], // Cargar el medio de contacto
      );

  // Convertir a Map
  Map<String, dynamic> toMap() => {
        "id": id, // Añadir el ID al mapa
        "plano": plano, // Añadir la ruta del plano al mapa
        "imagenes":
            imagenes, // Añadir la ruta de la imagen de referencia al mapa
        "unidad": unidad, // Añadir la unidad de medida al mapa
        "description": description, // Añadir la descripción al mapa
        "selectedContact":
            selectedContact, // Añadir el medio de contacto al mapa
      };
}
