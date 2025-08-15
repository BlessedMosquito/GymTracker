import 'package:flutter/material.dart';

class CreateSchedulePage extends StatelessWidget {
  const CreateSchedulePage({super.key});

    final List<String> daysOfWeek = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  
  void _openDayDialog(BuildContext context, String day) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$day - Exercises"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tutaj będzie lista ćwiczeń"),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // logika dodawania ćwiczenia
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Exercise"),
              ),
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
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Training Schedule")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: daysOfWeek.map((day) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () => _openDayDialog(context, day),
                child: Text(day),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
