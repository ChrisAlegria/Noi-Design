import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {
  final Widget child;

  const FondoLogin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/Logo.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          this.child,
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  // const _PurpleBox({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      // color: Colors.indigo,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 41, 123, 1),
            Color.fromRGBO(99, 152, 254, 1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 120,
            left: 120,
            child: _Esfera(),
          ),
          Positioned(
            top: 50,
            left: 135,
            child: _Esfera(),
          ),
          Positioned(
            top: 100,
            left: 190,
            child: _Esfera(),
          ),
        ],
      ),
    );
  }
}

class _Esfera extends StatelessWidget {
  const _Esfera({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
