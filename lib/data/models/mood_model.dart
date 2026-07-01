import 'package:mood_study_app/domain/entities/mood_entity.dart';

class MoodModel extends MoodEntity {
  MoodModel({
    super.id,
    required super.mood,
    required super.recommendation,
    required super.focusTime,
    required super.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mood': mood,
      'recommendation': recommendation,
      'date': date,
      'focusTime': focusTime,
    };
  }

  factory MoodModel.fromMap(Map<String, dynamic> map) {
    return MoodModel(
      id: map['id'],
      mood: map['mood'] ?? 'Unknown',
      recommendation: map['recommendation'] ?? '',
      date: map['date'] ?? '',
      focusTime: map['focusTime'] ?? '0 min',
    );
  }
}
