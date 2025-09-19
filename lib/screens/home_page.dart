import 'package:flutter/material.dart';
import '../theme/gradient_app_bar.dart';
import '../theme/gradient_button.dart';
import '../theme/gradient_scaffold.dart';
import 'my_trainings_page.dart';
import 'create_schedule_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: const GradientAppBar(title: "Gym Tracker"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateSchedulePage()),
                );
              },
              child: const Text("Create Schedule"),
            ),
            const SizedBox(height: 20),
            GradientButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyTrainingsPage()),
                );
              },
              child: const Text("My Trainings"),
            ),
          ],
        ),
      ),
    );
  }
}
