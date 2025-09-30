import 'package:flutter/material.dart';
import '../data.dart';
import '../models/exercise.dart';
import '../models/trainings.dart';
import '../theme/gradient_scaffold.dart';
import 'package:flutter/cupertino.dart';

class CreateSchedulePage extends StatefulWidget {
  const CreateSchedulePage({super.key});

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  final List<String> daysOfWeek = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  int selectedSets = 1;
  int selectedReps = 1;
  static int maxSets = 10;
  static int maxReps = 30;

  final Map<String, List<Exercise>> schedule = {};

  void _openExerciseFormDialog(
      BuildContext context, String day, void Function(void Function()) setStateDialog) {
    final nameController = TextEditingController();
    final setsController = TextEditingController();
    final repsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Exercise"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Exercise name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
                                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Sets", style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      itemExtent: 32,
                      scrollController:
                          FixedExtentScrollController(initialItem: selectedSets - 1),
                      onSelectedItemChanged: (value) {
                        setStateDialog(() {
                          selectedSets = value + 1;
                        });
                      },
                      children: List.generate(maxSets, (index) => Center(child: Text("${index + 1}"))),
                    ),
                  ),
                  const SizedBox(height: 8),
               const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Reps", style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      itemExtent: 32,
                      scrollController:
                          FixedExtentScrollController(initialItem: selectedReps - 1),
                      onSelectedItemChanged: (value) {
                        setStateDialog(() {
                          selectedReps = value + 1;
                        });
                      },
                      children:
                          List.generate(maxReps, (index) => Center(child: Text("${index + 1}"))),
                    ),
                  ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  final name = nameController.text;
                  final sets = selectedSets;
                  final reps = selectedReps;

                  if (name.isEmpty || name == '') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Invalid data"),
                      content: const Text("Please fill all fields correctly."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                  return;
                }


                  setState(() {
                    schedule.putIfAbsent(day, () => []);
                    schedule[day]!.add(
                      Exercise(exerciseName: name, sets: sets, reps: reps),
                    );
                  });

                  setStateDialog(() {});

                  Navigator.of(context).pop(); // zamykamy tylko formularz
                },
                child: const Text("Save"),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openDayDialog(BuildContext context, String day) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            final exercises = schedule[day] ?? [];
            return AlertDialog(
              title: Text("$day - Exercises"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        _openExerciseFormDialog(context, day, setStateDialog);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add Exercise"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (exercises.isEmpty)
                    const Text("No exercises yet"),
                  if (exercises.isNotEmpty)
                    ...exercises.map((e) => ListTile(
                          title: Text(e.exerciseName),
                          subtitle: Text("${e.sets} sets x ${e.reps} reps"),
                        )),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _saveTraining() {
    final hasExercises = schedule.values.any((list) => list.isNotEmpty);

    if (!hasExercises) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Training must contain exercises!")),
      );
      return;
    }

    final training = Training(
      name: "Training ${trainings.length + 1}",
      schedule: Map.from(schedule),
    );

    trainings.add(training);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${training.name} saved!")),
    );

    setState(() {
      schedule.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: const Text("Create Training Schedule", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...daysOfWeek.map((day) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => _openDayDialog(context, day),
                    child: Text(day),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _saveTraining,
                child: const Text("Save Training"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
