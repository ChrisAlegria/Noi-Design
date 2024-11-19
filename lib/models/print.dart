import 'dart:convert';

class Print {
  String titulo;
  String selectedContact;
  String description;
  String escala;
  String material;
  String? id;
  String userEmail;
  bool? isFinalized;

  Print({
    required this.titulo,
    required this.selectedContact,
    required this.description,
    required this.userEmail,
    required this.material,
    required this.escala,
    this.id,
    this.isFinalized = false,
  });

  String toJson() => json.encode(toMap());

  factory Print.fromJson(String str) => Print.fromMap(json.decode(str));

  factory Print.fromMap(Map<String, dynamic> json) => Print(
        titulo: json["title"],
        selectedContact: json["selectedContact"],
        description: json["description"],
        material: json["selectedMaterial"],
        escala: json["selectedScale"],
        id: json["id"],
        userEmail: json["userEmail"],
        isFinalized: json["isFinalized"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "title": titulo,
        "selectedContact": selectedContact,
        "description": description,
        "selectedMaterial": material,
        "selectedScale": escala,
        "id": id,
        "userEmail": userEmail,
        "isFinalized": isFinalized,
      };
}
