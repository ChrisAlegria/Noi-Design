import 'package:flutter/material.dart';
import 'package:noi_design/pages/home_page.dart';
import 'package:noi_design/pages/login_page.dart';
import 'package:noi_design/pages/register_page.dart';
import 'package:noi_design/services/print_design_service.dart';
import 'package:noi_design/services/user_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PrintAndDesignService(),
        ),
        ChangeNotifierProvider<UserService>(
          // Cambiado a ChangeNotifierProvider
          create: (_) => UserService(),
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
      title: 'login',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        'register': (context) => RegisterPage(),
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
