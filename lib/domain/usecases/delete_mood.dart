import '../repositories/mood_repository.dart';

class DeleteMood {
  final MoodRepository repository;

  DeleteMood(this.repository);

  Future<void> call(int id) async {
    await repository.deleteMood(id);
  }
}
