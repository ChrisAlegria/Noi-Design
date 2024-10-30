import 'dart:convert';

class Users {
  String nombre;
  String email;
  String phone;
  String password;
  String? id;

  Users({
    required this.nombre,
    required this.email,
    required this.phone,
    required this.password,
    this.id,
  });

  // Crear un objeto `Users` a partir de un JSON string
  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  // Convertir el objeto `Users` a JSON string
  String toJson() => json.encode(toMap());

  // Crear un objeto `Users` desde un mapa de datos
  factory Users.fromMap(Map<String, dynamic> json) => Users(
        nombre: json["nombre"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"], // Mapeamos el campo contraseña
        id: json.containsKey("id") ? json["id"] : null,
      );

  // Convertir el objeto `Users` en un mapa de datos
  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
        "phone": phone,
        "password": password,
      };

  // Método para crear una copia del objeto `Users`
  Users copy() => Users(
        nombre: this.nombre,
        email: this.email,
        phone: this.phone,
        password: this.password,
        id: this.id,
      );
}
