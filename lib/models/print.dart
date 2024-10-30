import 'dart:convert';

class Print {
  String id; // ID del objeto Print
  String modelo; // Modelo de impresión
  String material; // Material de impresión
  String escala; // Escala de impresión
  String descripcion; // Descripción
  String medioContacto; // Medio de contacto

  Print({
    required this.id,
    required this.modelo,
    required this.material,
    required this.escala,
    required this.descripcion,
    required this.medioContacto,
  });

  // Convertir desde JSON
  factory Print.fromJson(String str) => Print.fromMap(json.decode(str));

  // Convertir a JSON
  String toJson() => json.encode(toMap());

  // Convertir desde Map
  factory Print.fromMap(Map<String, dynamic> json) => Print(
        id: json["id"], // Cargar el ID
        modelo: json["modelo"], // Cargar el modelo
        material: json["material"], // Cargar el material
        escala: json["escala"], // Cargar la escala
        descripcion: json["descripcion"], // Cargar la descripción
        medioContacto: json["medioContacto"], // Cargar el medio de contacto
      );

  // Convertir a Map
  Map<String, dynamic> toMap() => {
        "id": id, // Añadir el ID al mapa
        "modelo": modelo, // Añadir el modelo al mapa
        "material": material, // Añadir el material al mapa
        "escala": escala, // Añadir la escala al mapa
        "descripcion": descripcion, // Añadir la descripción al mapa
        "medioContacto": medioContacto, // Añadir el medio de contacto al mapa
      };
}
