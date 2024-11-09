import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noi_design/models/print.dart';
import 'package:noi_design/models/design.dart';
import 'package:noi_design/services/print_service.dart';
import 'package:noi_design/services/design_service.dart';
import 'package:noi_design/widgets/global_user.dart';
import 'package:noi_design/widgets/auth_service.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalUser = Provider.of<GlobalUser>(context);
    final String userEmail = globalUser.email;

    final printService = Provider.of<PrintService>(context);
    final designService = Provider.of<DesignService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/Logo.jpg'),
            ),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Pedidos de Impresión - Admin',
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
                      itemCount: printService.prints.length,
                      itemBuilder: (context, index) {
                        final Print printOrder = printService.prints[index];
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
                            trailing: ElevatedButton.icon(
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Confirmar Finalización'),
                                      content: const Text(
                                          '¿Estás seguro de que deseas finalizar este pedido?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Finalizar'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  try {
                                    await printService
                                        .finalizePrint(printOrder.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Pedido finalizado")),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Error al finalizar el pedido")),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.check),
                              label: const Text('Finalizar Pedido'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Pedidos de Diseño - Admin',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  if (designService.designs.isEmpty)
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
                      itemCount: designService.designs.length,
                      itemBuilder: (context, index) {
                        final Design designOrder = designService.designs[index];
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
                            trailing: ElevatedButton.icon(
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Confirmar Finalización'),
                                      content: const Text(
                                          '¿Estás seguro de que deseas finalizar este pedido?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Finalizar'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  try {
                                    await designService
                                        .finalizeDesign(designOrder.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Pedido finalizado")),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Error al finalizar el pedido")),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.check),
                              label: const Text('Finalizar Pedido'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
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
