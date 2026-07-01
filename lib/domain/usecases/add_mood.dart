import 'package:mood_study_app/domain/entities/mood_entity.dart';
import 'package:mood_study_app/domain/repositories/mood_repository.dart';

class AddMood {
  final MoodRepository repository;
  AddMood(this.repository);

  Future<void> call(MoodEntity mood) async {
    await repository.addMood(mood);
  }
}
