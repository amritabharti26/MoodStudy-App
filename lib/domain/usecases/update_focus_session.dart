import '../entities/focus_session_entity.dart';
import '../repositories/focus_repository.dart';

class UpdateFocusSession {
  final FocusRepository repository;

  UpdateFocusSession(this.repository);

  Future<void> call(FocusSessionEntity session) async {
    await repository.updateFocusSession(session);
  }
}
