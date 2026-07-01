import '../repositories/focus_repository.dart';

class DeleteFocusSession {
  final FocusRepository repository;

  DeleteFocusSession(this.repository);

  Future<void> call(int id) async {
    await repository.deleteFocusSession(id);
  }
}
