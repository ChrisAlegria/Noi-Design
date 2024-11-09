import 'package:flutter/material.dart';
import 'package:noi_design/pages/admin_page.dart';
import 'package:noi_design/pages/home_page.dart';
import 'package:noi_design/pages/login_page.dart';
import 'package:noi_design/pages/register_page.dart';
import 'package:noi_design/services/design_service.dart';
import 'package:noi_design/services/user_service.dart';
import 'package:noi_design/services/print_service.dart';
import 'package:provider/provider.dart';
import 'package:noi_design/widgets/global_user.dart'; // Asegúrate de importar tu nuevo archivo

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DesignService(),
        ),
        ChangeNotifierProvider(
          create: (_) => PrintService(),
        ),
        ChangeNotifierProvider<UserService>(
          // Cambiado a ChangeNotifierProvider
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (context) => GlobalUser(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noi Design',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        'register': (context) => RegisterPage(),
        'adminPage': (context) => AdminPage(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Color.fromRGBO(0, 41, 123, 1),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Color.fromRGBO(0, 41, 123, 1),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
