import 'package:mood_study_app/core/database_helper.dart';
import 'package:mood_study_app/data/models/mood_model.dart';

abstract class MoodLocalDataSource {
  Future<void> addMood(MoodModel mood);

  Future<List<MoodModel>> getAllMoods();

  Future<void> deleteMood(int id);
}

class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  @override
  Future<void> addMood(MoodModel mood) async {
    await DatabaseHelper.instance.insert('mood_table', mood.toMap());
  }

  @override
  Future<List<MoodModel>> getAllMoods() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query('mood_table');

    return result.map((e) => MoodModel.fromMap(e)).toList();
  }

  @override
  Future<void> deleteMood(int id) async {
    final db = await DatabaseHelper.instance.database;

    await db.delete("mood_table", where: "id = ?", whereArgs: [id]);
  }
}
