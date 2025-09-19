class Exercise {
  final String exerciseName;
  final int sets;
  final int reps;

  Exercise({
    required this.exerciseName,
    required this.sets,
    required this.reps,
  });

  @override
  String toString() => "$exerciseName - $sets sets x $reps reps";
}
