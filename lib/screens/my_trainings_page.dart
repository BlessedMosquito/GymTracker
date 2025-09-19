import 'package:flutter/material.dart';
import '../data.dart';
import '../models/trainings.dart';
import 'training_detail_page.dart';
import '../theme/gradient_scaffold.dart';
import '../theme/gradient_app_bar.dart';

class MyTrainingsPage extends StatelessWidget {
  const MyTrainingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: const GradientAppBar(title: "My Trainings"),
      body: trainings.isEmpty
          ? const Center(
              child: Text(
                "No trainings yet",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: trainings.length,
              itemBuilder: (context, index) {
                final training = trainings[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: ListTile(
                    title: Text(
                      training.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrainingDetailPage(training: training),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
