class MoodEntity {
  final int? id;
  final String mood;
  final String recommendation;
  final String date;
  final String focusTime;

  MoodEntity({
    this.id,
    required this.mood,
    required this.recommendation,
    required this.date,
    required this.focusTime,
  });
}
