import 'package:flutter/material.dart';

class SpaView extends StatefulWidget {
  const SpaView({super.key});

  @override
  State<SpaView> createState() => _SpaViewState();
}

class _SpaViewState extends State<SpaView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("Spa"),
        ],
      ),
    );
  }
}
