import 'package:flutter/material.dart';
import 'package:noi_design/pages/orders_page.dart';
import 'package:noi_design/widgets/card_container.dart';
import 'package:noi_design/pages/prints_page.dart';
import 'package:noi_design/pages/design_page.dart';
import 'package:noi_design/widgets/auth_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdersPage(),
                  ),
                );
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
          // Contenido principal
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                // Mensaje de bienvenida
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Bienvenido a Noi Design',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tus ideas y diseños los llevamos a la impresión 3D.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Tarjetas
                CardContainer(
                  child: Column(
                    children: [
                      _ServiceCard(
                        imagePath: 'assets/images/imprecion.png',
                        title:
                            '¿Tienes algún modelo listo para llevar a la realidad?',
                        description:
                            'Nosotros lo imprimimos en 3D para ti con precisión y detalle.',
                        buttonText: 'Solicita tu impresión',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrintPage()),
                          );
                        },
                      ),
                      _ServiceCard(
                        imagePath: 'assets/images/diseño.png',
                        title:
                            '¿Tienes una idea en mente pero no sabes cómo diseñarlo?',
                        description:
                            'Déjanos ayudarte a transformarla en un diseño listo para impresión.',
                        buttonText: 'Solicita tu diseño',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DesignPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const _ServiceCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 56, 165, 1),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(description),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 56, 165, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
