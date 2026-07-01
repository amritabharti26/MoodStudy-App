import '../entities/focus_session_entity.dart';
import '../repositories/focus_repository.dart';

class AddFocusSession {
  final FocusRepository repository;

  AddFocusSession(this.repository);

  Future<int> call(FocusSessionEntity session) async {
    return await repository.addFocusSession(session);
  }
}
