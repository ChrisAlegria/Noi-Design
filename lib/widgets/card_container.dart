import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: this.child,
        width: double.infinity,
        // height: 300,
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
