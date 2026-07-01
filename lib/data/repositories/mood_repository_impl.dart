import '../../core/database_helper.dart';
import '../../domain/entities/mood_entity.dart';
import '../../domain/repositories/mood_repository.dart';
import '../database/mood_local_datasource.dart';
import '../models/mood_model.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource localDataSource;

  MoodRepositoryImpl(this.localDataSource);

  @override
  Future<void> addMood(MoodEntity mood) async {
    final moodModel = MoodModel(
      id: mood.id,
      mood: mood.mood,
      recommendation: mood.recommendation,
      focusTime: mood.focusTime,
      date: mood.date,
    );
    await localDataSource.addMood(moodModel);
  }

  @override
  Future<List<MoodModel>> getAllMoods() async {
    return await localDataSource.getAllMoods();
  }

  @override
  Future<void> deleteMood(int id) async {
    await localDataSource.deleteMood(id);
  }
}
