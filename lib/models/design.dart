import 'dart:convert';

class Design {
  String titulo;
  String selectedContact;
  String description;
  String unidad;
  String? plano;
  String? imagenes;
  String?
      id; // Asegúrate de que este valor sea opcional si no siempre se proporciona
  String userEmail;

  Design({
    required this.titulo,
    required this.selectedContact,
    required this.description,
    required this.userEmail,
    required this.unidad,
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
        titulo: json["title"],
        selectedContact: json["selectedContact"],
        description: json["description"],
        unidad: json["selectedUnity"],
        plano: json["planoFilePath"],
        imagenes: json["imageFilePath"],
        id: json["id"], // Asignamos el id (si existe)
        userEmail: json["userEmail"], // Asegúrate de incluir el userEmail aquí
      );

  // Convertir a un mapa de datos
  Map<String, dynamic> toMap() => {
        "title": titulo,
        "selectedContact": selectedContact,
        "description": description,
        "selectedUnity": unidad,
        "planoFilePath": plano,
        "imageFilePath": imagenes,
        "id": id, // Asegúrate de agregar el id al mapa
        "userEmail": userEmail, // Agrega el userEmail al mapa
      };
}
