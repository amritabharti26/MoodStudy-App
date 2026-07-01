import '../entities/mood_entity.dart';

abstract class MoodRepository {
  Future<void> addMood(MoodEntity mood);

  Future<List<MoodEntity>> getAllMoods();

  Future<void> deleteMood(int id);
}
