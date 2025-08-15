import 'package:flutter/material.dart';

class MyTrainingsPage extends StatelessWidget {
  const MyTrainingsPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trainings'),
      ),
      body: const Center(
        child: Text('Here will be a list of your trainings'),
      ),
    );
  }
}
