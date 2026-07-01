import 'package:mood_study_app/domain/entities/mood_entity.dart';
import 'package:mood_study_app/domain/repositories/mood_repository.dart';

class GetMood {
  final MoodRepository repository;
  GetMood(this.repository);

  Future<List<MoodEntity>> call() async {
    return await repository.getAllMoods();
  }
}
