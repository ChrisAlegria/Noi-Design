import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noi_design/models/print.dart';
import 'package:noi_design/models/design.dart';
import 'package:noi_design/services/print_service.dart';
import 'package:noi_design/services/design_service.dart';
import 'package:noi_design/widgets/global_user.dart';
import 'package:noi_design/widgets/auth_service.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalUser = Provider.of<GlobalUser>(context);
    final String userEmail = globalUser.email;

    // Acceder a los servicios de impresión y diseño
    final printService = Provider.of<PrintService>(context);
    final designService = Provider.of<DesignService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0, // Si deseas que el AppBar no tenga sombra
        leading: Padding(
          padding:
              const EdgeInsets.all(8.0), // Padding opcional alrededor del logo
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/Logo.jpg'),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.person,
              color: Color.fromRGBO(0, 41, 123, 1),
            ),
            onSelected: (String value) {
              if (value == 'Mis pedidos') {
              } else if (value == 'Logout') {
                logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Mis pedidos', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedidos de Impresión',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Lista de pedidos de impresión
              printService.prints.isEmpty
                  ? Center(child: Text("No hay pedidos de impresión"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // Evita que se desplace
                      itemCount: printService.prints.length,
                      itemBuilder: (context, index) {
                        final Print printOrder = printService.prints[index];
                        if (printOrder.userEmail != userEmail)
                          return Container(); // Filtra por usuario
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(printOrder.titulo),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Material: ${printOrder.material}"),
                                Text(
                                    "Escala de Impresión: ${printOrder.escala}"),
                                Text(
                                    "Contacto Preferido: ${printOrder.selectedContact}"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await printService.deletePrint(printOrder.id!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Pedido de impresión eliminado")),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 20),
              Text(
                'Pedidos de Diseño',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Lista de pedidos de diseño
              designService.design.isEmpty
                  ? Center(child: Text("No hay pedidos de diseño"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // Evita que se desplace
                      itemCount: designService.design.length,
                      itemBuilder: (context, index) {
                        final Design designOrder = designService.design[index];
                        if (designOrder.userEmail != userEmail)
                          return Container(); // Filtra por usuario
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(designOrder.titulo),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Unidad de Medida: ${designOrder.unidad}"),
                                Text(
                                    "Contacto Favorito: ${designOrder.selectedContact}"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await designService
                                    .deleteDesign(designOrder.id!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Pedido de diseño eliminado")),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
