import 'package:flutter/material.dart';
import '../models/trainings.dart';
import '../models/exercise.dart';
import '../theme/gradient_scaffold.dart';
import '../theme/gradient_app_bar.dart';

class TrainingDetailPage extends StatefulWidget {
  final Training training;

  const TrainingDetailPage({super.key, required this.training});

  @override
  State<TrainingDetailPage> createState() => _TrainingDetailPageState();
}

class _TrainingDetailPageState extends State<TrainingDetailPage> {
  void _editExercise(String day, int index, Exercise exercise) {
    final nameController = TextEditingController(text: exercise.exerciseName);
    final setsController = TextEditingController(text: exercise.sets.toString());
    final repsController = TextEditingController(text: exercise.reps.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Exercise"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Exercise name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: setsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Sets"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: repsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Reps"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newName = nameController.text;
                final newSets = int.tryParse(setsController.text) ?? 0;
                final newReps = int.tryParse(repsController.text) ?? 0;

                setState(() {
                  widget.training.schedule[day]![index] =
                      Exercise(exerciseName: newName, sets: newSets, reps: newReps);
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _deleteExercise(String day, int index) {
    setState(() {
      widget.training.schedule[day]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: GradientAppBar(title: widget.training.name),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: widget.training.schedule.entries.map((entry) {
          final day = entry.key;
          final exercises = entry.value;

          return ExpansionTile(
            title: Text(day),
            children: exercises.asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(e.exerciseName, style: const TextStyle(color: Colors.black)),
                  subtitle: Text("${e.sets} sets x ${e.reps} reps", style: const TextStyle(color: Colors.black)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editExercise(day, index, e),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteExercise(day, index),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
