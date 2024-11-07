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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0, // Si deseas que el AppBar no tenga sombra
        leading: const Padding(
          padding: EdgeInsets.all(8.0), // Padding opcional alrededor del logo
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/Logo.jpg'),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.person,
              color: Color.fromRGBO(0, 41, 123, 1),
            ),
            onSelected: (String value) {
              if (value == 'Logout') {
                logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return const {'Mis pedidos', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo de degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 41, 123, 1),
                  Color.fromRGBO(99, 152, 254, 1),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pedidos de Impresión',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  if (printService.prints.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "No hay pedidos de impresión",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: printService.prints
                          .where((p) => p.userEmail == userEmail)
                          .length,
                      itemBuilder: (context, index) {
                        final Print printOrder = printService.prints
                            .where((p) => p.userEmail == userEmail)
                            .toList()[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              printOrder.titulo,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 56, 165, 1)),
                            ),
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
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                try {
                                  await printService
                                      .deletePrint(printOrder.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Pedido de impresión eliminado")),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Error al eliminar el pedido")),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Pedidos de Diseño',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  if (designService.design.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "No hay pedidos de diseño",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: designService.design
                          .where((d) => d.userEmail == userEmail)
                          .length,
                      itemBuilder: (context, index) {
                        final Design designOrder = designService.design
                            .where((d) => d.userEmail == userEmail)
                            .toList()[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              designOrder.titulo,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 56, 165, 1)),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Unidad de Medida: ${designOrder.unidad}"),
                                Text(
                                    "Contacto Favorito: ${designOrder.selectedContact}"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                try {
                                  await designService
                                      .deleteDesign(designOrder.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Pedido de diseño eliminado")),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Error al eliminar el pedido")),
                                  );
                                }
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
        ],
      ),
    );
  }
}
