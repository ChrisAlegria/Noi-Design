import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prints'),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(0, 41, 123, 1),
        ),
      ),
    );
  }
}
