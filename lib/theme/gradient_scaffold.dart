import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const GradientScaffold({super.key, this.appBar, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF616161), // ciemny szary
            Color(0xFF9E9E9E), // średni szary
            Color(0xFFBDBDBD), // jasny szary
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // pozwala gradientowi prześwitywać
        appBar: appBar,
        body: body,
      ),
    );
  }
}
