import 'dart:convert';

class Design {
  String titulo;
  String selectedContact;
  String description;
  String unidad;
  String? plano;
  String? imagenes;
  String? id;
  String userEmail;
  bool? isFinalized;

  Design({
    required this.titulo,
    required this.selectedContact,
    required this.description,
    required this.userEmail,
    required this.unidad,
    this.plano,
    this.imagenes,
    this.id,
    this.isFinalized = false,
  });

  String toJson() => json.encode(toMap());

  factory Design.fromJson(String str) => Design.fromMap(json.decode(str));

  factory Design.fromMap(Map<String, dynamic> json) => Design(
        titulo: json["title"],
        selectedContact: json["selectedContact"],
        description: json["description"],
        unidad: json["selectedUnity"],
        plano: json["planoFilePath"],
        imagenes: json["imageFilePath"],
        id: json["id"],
        userEmail: json["userEmail"],
        isFinalized: json["isFinalized"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "title": titulo,
        "selectedContact": selectedContact,
        "description": description,
        "selectedUnity": unidad,
        "planoFilePath": plano,
        "imageFilePath": imagenes,
        "id": id,
        "userEmail": userEmail,
        "isFinalized": isFinalized,
      };
}
