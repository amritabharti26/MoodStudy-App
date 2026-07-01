import '../../domain/entities/focus_session_entity.dart';

class FocusSessionModel extends FocusSessionEntity {
  const FocusSessionModel({
    super.id,
    required super.mood,
    required super.allocatedSeconds,
    required super.studiedSeconds,
    required super.status,
    required super.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "mood": mood,
      "allocatedSeconds": allocatedSeconds,
      "studiedSeconds": studiedSeconds,
      "status": status,
      "date": date,
    };
  }

  factory FocusSessionModel.fromMap(Map<String, dynamic> map) {
    return FocusSessionModel(
      id: map["id"],
      mood: map["mood"],
      allocatedSeconds: map["allocatedSeconds"],
      studiedSeconds: map["studiedSeconds"],
      status: map["status"],
      date: map["date"],
    );
  }
}
