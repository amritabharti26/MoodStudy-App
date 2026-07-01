import '../entities/focus_session_entity.dart';

abstract class FocusRepository {
  Future<int> addFocusSession(FocusSessionEntity session);

  Future<List<FocusSessionEntity>> getFocusSessions();

  Future<void> updateFocusSession(FocusSessionEntity session);

  Future<void> deleteFocusSession(int id);
}
