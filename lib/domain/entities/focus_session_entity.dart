class FocusSessionEntity {
  final int? id;
  final String mood;
  final int allocatedSeconds;
  final int studiedSeconds;
  final String status;
  final String date;

  const FocusSessionEntity({
    this.id,
    required this.mood,
    required this.allocatedSeconds,
    required this.studiedSeconds,
    required this.status,
    required this.date,
  });
}
